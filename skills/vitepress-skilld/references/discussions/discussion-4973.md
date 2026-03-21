---
number: 4973
title: 使用cloudflare pages部署站点会导致所有页面的最后更新时间一致的问题
category: "Q&A"
created: 2025-10-06
url: "https://github.com/vuejs/vitepress/discussions/4973"
upvotes: 1
comments: 1
answered: true
---

# 使用cloudflare pages部署站点会导致所有页面的最后更新时间一致的问题

即使本地部署可以看到每个页面的更新时间是不同的，但通过cf pages部署后，每个页面上的更新时间都会一致显示为最后提交更新的时间

---

## Accepted Answer

**@brc-dd** [maintainer]:

Hmm, very weird. Is the site/repo public? Can you try deploying again or maybe clearing your browser cache? If the build logs are accessible, does it show any git fetch step? Does your GitHub repo show correct history?

It seemed to work fine fine for others - https://blog.cat73.org/posts/2024/05-cloudflare-vitepress-lastupdate, https://neon-blog.pages.dev/miscellaneous/vitepress_fix_cloudflare_page_lastUpdated_display_error, https://github.com/vuejs/vitepress/discussions/3580