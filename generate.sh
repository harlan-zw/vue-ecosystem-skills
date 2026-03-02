#!/usr/bin/env bash
set -euo pipefail

MODEL="sonnet"
EJECT_DIR="./skills"
SKILLD="npx -y skilld@v0.13.2"
REFS_ONLY=false

PACKAGES=(
  # Core
  vue@beta
  vue-router
  pinia

#  # Build & Test
  "@vue/test-utils"
#
#  # State & Data
  "@tanstack/vue-query"
  "@tanstack/vue-table"
  "@tanstack/vue-form"
  "@tanstack/vue-router"
  "@tanstack/vue-virtual"
  "@tanstack/vue-store"
  "@tanstack/ai-vue"
  "@pinia/colada"
#
#  # Utilities
  @unhead/vue
  vue-i18n
#
#  # UI
  reka-ui
  primevue
  vuetify@next
  motion-v
  shadcn-vue
  quasar
#
#  # Forms
  vee-validate
  "@formkit/core"
#
#  # Presentations & Docs
  "@slidev/cli"
  vitepress
#
#  # 3D
  "@tresjs/core"
#
#  # VueUse
  "@vueuse/core"
  "@vueuse/shared"
  "@vueuse/components"
  "@vueuse/integrations"
  "@vueuse/math"
  "@vueuse/motion"

  # charts
  @unovis/ts
  @unovis/vue
  vue-data-ui
  @floating-ui/vue
)

# Parse flags
POSITIONAL=()
for arg in "$@"; do
  case "$arg" in
    --refs-only)
      REFS_ONLY=true
      ;;
    *)
      POSITIONAL+=("$arg")
      ;;
  esac
done

# Explicit packages mode: ./generate.sh @vueuse/math @tanstack/vue-query quasar
EXPLICIT=false
if [ ${#POSITIONAL[@]} -gt 0 ]; then
  PACKAGES=("${POSITIONAL[@]}")
  EXPLICIT=true
fi

# Compute skill dir name matching skilld's computeSkillDirName()
skill_dir_name() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9._]/-/g; s/^[.\-]*//; s/[.\-]*$//' | head -c 255
}

# Stamp references_synced_at in SKILL.md frontmatter
stamp_synced_at() {
  local skill_md="$1"
  local sync_date
  sync_date=$(date -u +%Y-%m-%d)

  if grep -q "references_synced_at:" "$skill_md"; then
    sed -i "s/references_synced_at: .*/references_synced_at: $sync_date/" "$skill_md"
  else
    sed -i "/generated_at:/a\\  references_synced_at: $sync_date" "$skill_md"
  fi
}

total=${#PACKAGES[@]}
current=0
failed=()

echo "Skill Version: $($SKILLD --version)"
if [ "$REFS_ONLY" = true ]; then
  echo "Syncing references for $total skills (no LLM, SKILL.md untouched)"
else
  echo "Generating $total skills with model=$MODEL"
fi
echo "Output: $EJECT_DIR"
echo "---"

# Delete old output for explicit packages so we get a clean regeneration (skip in refs-only mode)
if [ "$EXPLICIT" = true ] && [ "$REFS_ONLY" = false ]; then
  for pkg in "${PACKAGES[@]}"; do
    # Strip version suffix (e.g. vue@beta -> vue, vuetify@next -> vuetify)
    bare=$(echo "$pkg" | sed 's/@[^/]*$//')
    dir_name="$(skill_dir_name "$bare")-skilld"
    target="$EJECT_DIR/$dir_name"
    if [ -d "$target" ]; then
      echo "Removing $target"
      rm -rf "$target"
    fi
  done
  echo "---"
fi

for pkg in "${PACKAGES[@]}"; do
  current=$((current + 1))

  bare=$(echo "$pkg" | sed 's/@[^/]*$//')
  dir_name="$(skill_dir_name "$bare")-skilld"
  skill_path="$EJECT_DIR/$dir_name"
  skill_md="$skill_path/SKILL.md"

  # Skip pre-generated skills in default full-generation mode
  if [ "$EXPLICIT" = false ] && [ "$REFS_ONLY" = false ]; then
    if [ -d "$skill_path" ]; then
      echo "[$current/$total] $pkg (skipped — already exists)"
      echo ""
      continue
    fi
  fi

  # In refs-only mode, skip packages that don't have an existing skill dir
  if [ "$REFS_ONLY" = true ] && [ ! -d "$skill_path" ]; then
    echo "[$current/$total] $pkg (skipped — no existing skill)"
    echo ""
    continue
  fi

  echo "[$current/$total] $pkg"

  # Build eject args: omit --model in refs-only mode so skilld skips LLM generation
  eject_args=("$pkg" --out "$EJECT_DIR" --yes --force)
  if [ "$REFS_ONLY" = true ]; then
    eject_args+=(--debug)
  else
    eject_args+=(--model "$MODEL" --debug)
  fi

  if $SKILLD eject "${eject_args[@]}"; then
    if [ "$REFS_ONLY" = true ]; then
      stamp_synced_at "$skill_md"
    fi
    echo "  ✓ $pkg"
  else
    echo "  ✗ $pkg (failed)"
    failed+=("$pkg")
  fi

  echo ""
done

echo "=== Done ==="
if [ "$REFS_ONLY" = true ]; then
  echo "Synced: $((total - ${#failed[@]}))/$total"
else
  echo "Generated: $((total - ${#failed[@]}))/$total"
fi

if [ ${#failed[@]} -gt 0 ]; then
  echo "Failed:"
  for pkg in "${failed[@]}"; do
    echo "  - $pkg"
  done
  exit 1
fi
