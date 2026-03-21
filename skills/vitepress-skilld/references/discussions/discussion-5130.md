---
number: 5130
title: How to integrate with Netlify Forms for dynamic inputs
category: "Q&A"
created: 2026-02-27
url: "https://github.com/vuejs/vitepress/discussions/5130"
upvotes: 1
comments: 3
answered: false
---

# How to integrate with Netlify Forms for dynamic inputs

Netlify has a nice feature that allows to implement contact forms without any extra backend code

The documentation is here https://docs.netlify.com/manage/forms/setup/#html-forms

The project is that Netlify will do post-processing for the HTML code ... and then vitepress load the page with `Hydration completed but contains mismatches.` 

Has anyone integrated vitepress with Netlify forms?

Any idea for workarounds ?

I also tried the Ajax version, but the hidration error is still triggered.

Thanks!

---

## Top Comments

**@brc-dd** [maintainer] (+1):

Hmm, not sure but seems like it just works? https://vitepress-theme-default-plus.lando.dev/support.html (https://github.com/lando/vitepress-theme-default-plus/blob/main/docs/support.md?plain=1). Are you sure the hydration error is coming from the form? Can you try temporarily deploying the debug version (update command to `DEBUG=true vitepress build`) and see which nodes are mismatching?

**@adiroiban**:

I guess that this will work, as long as your have static markup... but as long as you add vuejs into the mix, things break apart.

I have documented a workaround to still get some dynamic inputs ... not idea... but for a simple form it should so the job.

Thanks again for the feedback!

**@adiroiban**:

I am reopening this.... even with static inputs and the form in the Markdown, it works when you load the page.... but if you navigate to a different page and then come back to the page, the forms no longer works

The implementation from https://vitepress-theme-default-plus.lando.dev/support.html seems to work... I am not sure what I am not doing right in my code.


--------

From Netlify docs


> When Netlify parses the static HTML for a form you’ve added, the build system automatically strips the data-netlify="true" or netlify attribute from the  tag and injects a hidden input...