---
number: 6063
title: "Cannot read properties of undefined (reading 'isDehydrated')"
category: "Q&A"
created: 2025-07-26
url: "https://github.com/TanStack/table/discussions/6063"
upvotes: 1
comments: 0
answered: false
---

# Cannot read properties of undefined (reading 'isDehydrated')

I'm consistently running into an error when trying to directly access an authenticated page by URL. The error message is:

client : **"Cannot read properties of undefined (reading 'isDehydrated')"**
<img width="1740" height="859" alt="image" src="https://github.com/user-attachments/assets/8493ffc2-fb43-4b71-a6ce-517908177f8c" />

server : **"tried to stream query ["all-users"] after stream was already closed"**
<img width="1713" height="1009" alt="image" src="https://github.com/user-attachments/assets/34351a62-495e-4860-bea0-f4cba09175fd" />


**(authenticated)/test.tsx**
...