---
title: "TanStack Query"
meta:
  "og:description": "Powerful asynchronous state management, server-state utilities and data fetching. Fetch, cache, update, and wrangle all forms of async data in your TS/JS, React, Vue, Solid, Svelte &amp; Angular applications all without touching any &quot;global state&quot;"
  "og:title": "TanStack Query"
  "twitter:description": "Powerful asynchronous state management, server-state utilities and data fetching. Fetch, cache, update, and wrangle all forms of async data in your TS/JS, React, Vue, Solid, Svelte &amp; Angular applications all without touching any &quot;global state&quot;"
  "twitter:title": "TanStack Query"
  description: "Powerful asynchronous state management, server-state utilities and data fetching. Fetch, cache, update, and wrangle all forms of async data in your TS/JS, React, Vue, Solid, Svelte &amp; Angular applications all without touching any &quot;global state&quot;"
---

# TanStackQuery

## **Powerful asynchronous state management, server-state utilities and data fetching**

Powerful asynchronous state management, server-state utilities and data fetching. Fetch, cache, update, and wrangle all forms of async data in your TS/JS, React, Vue, Solid, Svelte & Angular applications all without touching any "global state"

**Read the Docs**

0 ***NPM Downloads*** 0 ***Stars on Github***

0

***Contributors on GitHub***

0

***Dependents on GitHub***

**Just a quick look...**

```
import { useQuery } from '@tanstack/react-query'

function Todos() {
  const { data, isPending, error } = useQuery({
    queryKey: ['todos'],
    queryFn: () => fetch('/api/todos').then(r => r.json()),
  })

  if (isPending) return <span>Loading...</span>
  if (error) return <span>Oops!</span>

  return <ul>{data.map(t => <li key={t.id}>{t.title}</li>)}</ul>
}

export default Todos
```

### **Declarative & Automatic**

Writing your data fetching logic by hand is over. Tell TanStack Query where to get your data and how fresh you need it to be and the rest is automatic. It handles **caching, background updates and stale data out of the box with zero-configuration**.

### **Simple & Familiar**

If you know how to work with promises or async/await, then you already know how to use TanStack Query. There's **no global state to manage, reducers, normalization systems or heavy configurations to understand**. Simply pass a function that resolves your data (or throws an error) and the rest is history.

### **Extensible**

TanStack Query is configurable down to each observer instance of a query with knobs and options to fit every use-case. It comes wired up with **dedicated devtools, infinite-loading APIs, and first class mutation tools that make updating your data a breeze**. Don't worry though, everything is pre-configured for success!

### **Loved by Developers**

See what teams are saying

" Honestly, if React Query had been around before Redux, I don't think Redux would have been nearly as popular as it was. "

**Kent C. Dodds**

@kentcdodds · Epic Web

" If I could go back in time and mass myself... I would hand myself a flash drive with a copy of react-query on it. "

**Kent C. Dodds**

@kentcdodds · Epic Web

" React Query won. There's no denying that. "

**Theo Browne**

@t3dotgg · Ping Labs

" TanStack Query has been a game-changer for us. We love using it for react-admin. "

**react-admin**

@ReactAdmin · Marmelab

" The more I use React + Vite + TanStack Router + TypeScript + TanStack Query, the more I love it. "

**Catalin Pit**

@catalinmpit · Developer Advocate

" Combined with React Query, this stack has been a game-changer for my productivity. "

**Dominik (TkDodo)**

@TkDodo · TanStack

" Honestly, if React Query had been around before Redux, I don't think Redux would have been nearly as popular as it was. "

**Kent C. Dodds**

@kentcdodds · Epic Web

" If I could go back in time and mass myself... I would hand myself a flash drive with a copy of react-query on it. "

**Kent C. Dodds**

@kentcdodds · Epic Web

" React Query won. There's no denying that. "

**Theo Browne**

@t3dotgg · Ping Labs

" TanStack Query has been a game-changer for us. We love using it for react-admin. "

**react-admin**

@ReactAdmin · Marmelab

" The more I use React + Vite + TanStack Router + TypeScript + TanStack Query, the more I love it. "

**Catalin Pit**

@catalinmpit · Developer Advocate

" Combined with React Query, this stack has been a game-changer for my productivity. "

**Dominik (TkDodo)**

@TkDodo · TanStack

### **No dependencies. All the Features.**

With zero dependencies, TanStack Query is extremely lean given the dense feature set it provides. From weekend hobbies all the way to enterprise e-commerce systems (Yes, I'm lookin' at you Walmart!), TanStack Query is the battle-hardened tool to help you succeed at the speed of your creativity.

Backend agnostic Dedicated Devtools Auto Caching Auto Refetching Window Focus Refetching Polling/Realtime Queries Parallel Queries Dependent Queries Mutations API Automatic Garbage Collection Paginated/Cursor Queries Load-More/Infinite Scroll Queries Scroll Recovery Request Cancellation Suspense Ready! Render-as-you-fetch Prefetching Variable-length Parallel Queries Offline Support SSR Support Data Selectors

### **Less code, fewer edge cases.**

Instead of writing reducers, caching logic, timers, retry logic, complex async/await scripting (I could keep going...), you literally write a tiny fraction of the code you normally would. You will be surprised at how little code you're writing or how much code you're deleting when you use TanStack Query. Try it out with one of the examples below!

### **Maintainers**

View Tanner Linsley&#x27;s GitHub profile View Dominik Dorfmeister&#x27;s GitHub profile View Lachlan Collins&#x27;s GitHub profile View Vedanta Somnathe&#x27;s GitHub profile View Fredrik Höglund&#x27;s GitHub profile View Jonghyeon Ko&#x27;s GitHub profile View Arnoud de Vries&#x27;s GitHub profile View Aryan Deora&#x27;s GitHub profile View Damian Osipiuk&#x27;s GitHub profile View Eliya Cohen&#x27;s GitHub profile

**View All Maintainers**

### **Partners**

  &#x27;%3e%3cg%20fill-rule=&#x27;nonzero&#x27;%3e%3cpath%20d=&#x27;m1099.4%20549.4v-12.5h-21.3l-12.5%2012.5z&#x27;%20fill=&#x27;%23ff8b00&#x27;/%3e%3cpath%20d=&#x27;m1123.4%20518.4h-26.7l-12.6%2012.5h39.3z&#x27;%20fill=&#x27;%2355b2c6&#x27;/%3e%3cpath%20d=&#x27;m1053.2%20561.9%206.4-6.4h21.6v12.5h-28z&#x27;%20fill=&#x27;%23f00&#x27;/%3e%3cpath%20d=&#x27;m1057.9%20543.3h13.8l12.6-12.5h-26.4z&#x27;%20fill=&#x27;%23b4bbbf&#x27;/%3e%3cpath%20d=&#x27;m1042.8%20561.9h10.4l12.4-12.5h-22.8z&#x27;%20fill=&#x27;%23b4bbbf&#x27;/%3e%3cpath%20d=&#x27;m1096.7%20518.4-6.4%206.4h-40.8v-12.5h47.2z&#x27;%20fill=&#x27;%23b4bbbf&#x27;/%3e%3cpath%20d=&#x27;m828.6%20559.7h-19.6l-3.4%208.4h-8.6l18.1-42.4h7.5l18.1%2042.4h-8.7zm-2.7-6.7-7.1-17.3-7.1%2017.3z&#x27;%20fill=&#x27;%23031c4c&#x27;/%3e%3cpath%20d=&#x27;m960.1%20541.3c2.5-3.7%208.8-4.1%2011.4-4.1v7.2c-3.2%200-6.4.1-8.3%201.5s-2.9%203.3-2.9%205.6v16.6h-7.8v-30.9h7.5z&#x27;%20fill=&#x27;%23031c4c&#x27;/%3e%3c/g%3e%3cpath%20d=&#x27;m975.8%20537.2h7.8v30.9h-7.8z&#x27;%20fill=&#x27;%23031c4c&#x27;/%3e%3cpath%20d=&#x27;m975.8%20523.4h7.8v9.2h-7.8z&#x27;%20fill=&#x27;%23031c4c&#x27;/%3e%3cpath%20d=&#x27;m1022.3%20523.4v44.7h-7.5l-.2-4.7c-1.1%201.6-2.5%202.9-4.2%203.9-1.7.9-3.8%201.4-6.2%201.4-2.1%200-4.1-.4-5.8-1.1-1.8-.8-3.4-1.8-4.7-3.2s-2.4-3.1-3.1-5c-.8-1.9-1.1-4.1-1.1-6.5s.4-4.6%201.1-6.6c.8-2%201.8-3.7%203.1-5.1s2.9-2.5%204.7-3.3%203.7-1.2%205.8-1.2c2.4%200%204.4.4%206.1%201.3s3.1%202.1%204.2%203.8v-18.3h7.8zm-16.4%2038.6c2.6%200%204.6-.9%206.2-2.6s2.4-4%202.4-6.8-.8-5-2.4-6.8c-1.6-1.7-3.6-2.6-6.2-2.6-2.5%200-4.6.9-6.1%202.6-1.6%201.7-2.4%204-2.4%206.8s.8%205%202.4%206.7c1.6%201.8%203.6%202.7%206.1%202.7&#x27;%20fill=&#x27;%23031c4c&#x27;%20fill-rule=&#x27;nonzero&#x27;/%3e%3cpath%20d=&#x27;m885.8%20544.2h-19.3v6.7h11c-.3%203.4-1.6%206-3.8%208.1-2.2%202-5%203-8.6%203-2%200-3.9-.4-5.5-1.1-1.7-.7-3.1-1.7-4.3-3.1-1.2-1.3-2.1-2.9-2.8-4.8s-1-3.9-1-6.2.3-4.3%201-6.2c.6-1.9%201.6-3.4%202.8-4.8%201.2-1.3%202.6-2.3%204.3-3.1%201.7-.7%203.5-1.1%205.6-1.1%204.2%200%207.4%201%209.6%203l5.2-5.2c-3.9-3-8.9-4.6-14.8-4.6-3.3%200-6.3.5-9%201.6s-5%202.5-6.9%204.4-3.4%204.2-4.4%206.9-1.5%205.7-1.5%208.9.5%206.2%201.6%208.9%202.5%205%204.4%206.9%204.2%203.4%206.9%204.4c2.7%201.1%205.7%201.6%208.9%201.6s6.1-.5%208.7-1.6%204.8-2.5%206.6-4.4%203.2-4.2%204.2-6.9%201.5-5.7%201.5-8.9v-1.3c-.3-.2-.4-.7-.4-1.1&#x27;%20fill=&#x27;%23031c4c&#x27;%20fill-rule=&#x27;nonzero&#x27;/%3e%3cpath%20d=&#x27;m946.8%20544.2h-19.3v6.7h11c-.3%203.4-1.6%206-3.8%208.1-2.2%202-5%203-8.6%203-2%200-3.9-.4-5.5-1.1-1.7-.7-3.1-1.7-4.3-3.1-1.2-1.3-2.1-2.9-2.8-4.8s-1-3.9-1-6.2.3-4.3%201-6.2c.6-1.9%201.6-3.4%202.8-4.8%201.2-1.3%202.6-2.3%204.3-3.1%201.7-.7%203.5-1.1%205.6-1.1%204.2%200%207.4%201%209.6%203l5.2-5.2c-3.9-3-8.9-4.6-14.8-4.6-3.3%200-6.3.5-9%201.6s-5%202.5-6.9%204.4-3.4%204.2-4.4%206.9-1.5%205.7-1.5%208.9.5%206.2%201.6%208.9%202.5%205%204.4%206.9%204.2%203.4%206.9%204.4c2.7%201.1%205.7%201.6%208.9%201.6s6.1-.5%208.7-1.6%204.8-2.5%206.6-4.4%203.2-4.2%204.2-6.9%201.5-5.7%201.5-8.9v-1.3c-.3-.2-.4-.7-.4-1.1&#x27;%20fill=&#x27;%23031c4c&#x27;%20fill-rule=&#x27;nonzero&#x27;/%3e%3c/g%3e%3c/svg%3e)   &#x27;%3e%3cpath%20d=&#x27;M117.436%20207.036V154.604L118.529%20153.51H129.452L130.545%20154.604V207.036L129.452%20208.13H118.529L117.436%20207.036Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M117.436%2053.5225V1.09339L118.529%200H129.452L130.545%201.09339V53.5225L129.452%2054.6159H118.529L117.436%2053.5225Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M69.9539%20169.238H68.4094L60.6869%20161.512V159.967L78.7201%20141.938L86.8976%20141.942L87.9948%20143.031V151.209L69.9539%20169.238Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M69.9462%2038.8917H68.4017L60.6792%2046.6181V48.1626L78.7124%2066.192L86.8899%2066.1882L87.9871%2065.0986V56.9212L69.9462%2038.8917Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M1.09339%2097.5104H75.3711L76.4645%2098.6038V109.526L75.3711%20110.62H1.09339L0%20109.526V98.6038L1.09339%2097.5104Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M440.999%2097.5104H510.91L512.004%2098.6038V109.526L510.91%20110.62H436.633L435.539%20109.526L439.905%2098.6038L440.999%2097.5104Z&#x27;%20fill=&#x27;%2305BDBA&#x27;/%3e%3cpath%20d=&#x27;M212.056%20108.727L210.963%20109.821H177.079L175.986%20110.914C175.986%20113.101%20178.173%20119.657%20186.916%20119.657C190.196%20119.657%20193.472%20118.564%20194.566%20116.377L195.659%20115.284H208.776L209.869%20116.377C208.776%20122.934%20203.313%20132.774%20186.916%20132.774C168.336%20132.774%20159.589%20119.657%20159.589%20104.357C159.589%2089.0576%20168.332%2075.9408%20185.822%2075.9408C203.313%2075.9408%20212.056%2089.0576%20212.056%20104.357V108.731V108.727ZM195.659%2097.7971C195.659%2096.7037%20194.566%2089.0538%20185.822%2089.0538C177.079%2089.0538%20175.986%2096.7037%20175.986%2097.7971L177.079%2098.8905H194.566L195.659%2097.7971Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M242.66%20115.284C242.66%20117.47%20243.753%20118.564%20245.94%20118.564H255.776L256.87%20119.657V130.587L255.776%20131.681H245.94C236.103%20131.681%20227.36%20127.307%20227.36%20115.284V91.2368L226.266%2090.1434H218.617L217.523%2089.05V78.1199L218.617%2077.0265H226.266L227.36%2075.9332V66.0965L228.453%2065.0031H241.57L242.663%2066.0965V75.9332L243.757%2077.0265H255.78L256.874%2078.1199V89.05L255.78%2090.1434H243.757L242.663%2091.2368V115.284H242.66Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M283.1%20131.681H269.983L268.889%20130.587V56.2636L269.983%2055.1702H283.1L284.193%2056.2636V130.587L283.1%20131.681Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M312.61%2068.2871H299.493L298.399%2067.1937V56.2636L299.493%2055.1702H312.61L313.703%2056.2636V67.1937L312.61%2068.2871ZM312.61%20131.681H299.493L298.399%20130.587V78.1237L299.493%2077.0304H312.61L313.703%2078.1237V130.587L312.61%20131.681Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M363.98%2056.2636V67.1937L362.886%2068.2871H353.05C350.863%2068.2871%20349.769%2069.3805%20349.769%2071.5672V75.9408L350.863%2077.0342H361.793L362.886%2078.1276V89.0576L361.793%2090.151H350.863L349.769%2091.2444V130.591L348.676%20131.684H335.559L334.466%20130.591V91.2444L333.372%2090.151H325.723L324.629%2089.0576V78.1276L325.723%2077.0342H333.372L334.466%2075.9408V71.5672C334.466%2059.5438%20343.209%2055.1702%20353.046%2055.1702H362.882L363.976%2056.2636H363.98Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M404.42%20132.774C400.046%20143.704%20395.677%20150.261%20380.373%20150.261H374.906L373.813%20149.167V138.237L374.906%20137.144H380.373C385.836%20137.144%20386.929%20136.05%20388.023%20132.77V131.677L370.536%2089.05V78.1199L371.63%2077.0265H381.466L382.56%2078.1199L395.677%20115.284H396.77L409.887%2078.1199L410.98%2077.0265H420.817L421.91%2078.1199V89.05L404.424%20132.77L404.42%20132.774Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3cpath%20d=&#x27;M135.454%20131.681L134.361%20130.587L134.368%2098.9172C134.368%2093.4541%20132.22%2089.2182%20125.625%2089.0806C122.234%2088.9926%20118.354%2089.0729%20114.209%2089.2488L113.59%2089.8834L113.598%20130.587L112.504%20131.681H99.3913L98.2979%20130.587V77.5388L99.3913%2076.4454L128.901%2076.1778C143.685%2076.1778%20149.668%2086.3356%20149.668%2097.8009V130.587L148.575%20131.681H135.454Z&#x27;%20fill=&#x27;%23014847&#x27;/%3e%3c/g%3e%3cdefs%3e%3cclipPath%20id=&#x27;clip0_235_8&#x27;%3e%3crect%20width=&#x27;512&#x27;%20height=&#x27;208.126&#x27;%20fill=&#x27;white&#x27;/%3e%3c/clipPath%3e%3c/defs%3e%3c/svg%3e)  &#x27;%3e%3cpath%20fill-rule=&#x27;evenodd&#x27;%20clip-rule=&#x27;evenodd&#x27;%20d=&#x27;M0%207.58621C0%203.39646%203.44137%200%207.68651%200H36.8952C41.1404%200%2044.5817%203.39646%2044.5817%207.58621V32.104C44.5817%2036.4386%2039.0241%2038.3197%2036.3287%2034.8976L27.902%2024.1991V37.1724C27.902%2040.9432%2024.8048%2044%2020.9842%2044H7.68651C3.44137%2044%200%2040.6035%200%2036.4138V7.58621ZM7.68651%206.06897C6.83748%206.06897%206.14921%206.74826%206.14921%207.58621V36.4138C6.14921%2037.2517%206.83748%2037.931%207.68651%2037.931H21.2148C21.6393%2037.931%2021.7528%2037.5914%2021.7528%2037.1724V19.7752C21.7528%2015.4407%2027.3104%2013.5594%2030.0059%2016.9816L38.4325%2027.6801V7.58621C38.4325%206.74826%2038.5129%206.06897%2037.6639%206.06897H7.68651Z&#x27;%20fill=&#x27;%2332C0ED&#x27;/%3e%3cpath%20fill-rule=&#x27;evenodd&#x27;%20clip-rule=&#x27;evenodd&#x27;%20d=&#x27;M0%207.58621C0%203.39646%203.44137%200%207.68651%200H36.8952C41.1404%200%2044.5817%203.39646%2044.5817%207.58621V32.104C44.5817%2036.4386%2039.0241%2038.3197%2036.3287%2034.8976L27.902%2024.1991V37.1724C27.902%2040.9432%2024.8048%2044%2020.9842%2044H7.68651C3.44137%2044%200%2040.6035%200%2036.4138V7.58621ZM7.68651%206.06897C6.83748%206.06897%206.14921%206.74826%206.14921%207.58621V36.4138C6.14921%2037.2517%206.83748%2037.931%207.68651%2037.931H21.2148C21.6393%2037.931%2021.7528%2037.5914%2021.7528%2037.1724V19.7752C21.7528%2015.4407%2027.3104%2013.5594%2030.0059%2016.9816L38.4325%2027.6801V7.58621C38.4325%206.74826%2038.5129%206.06897%2037.6639%206.06897H7.68651Z&#x27;%20fill=&#x27;url(%23paint0_linear_8138_23)&#x27;/%3e%3cpath%20fill-rule=&#x27;evenodd&#x27;%20clip-rule=&#x27;evenodd&#x27;%20d=&#x27;M0%207.58621C0%203.39646%203.44137%200%207.68651%200H36.8952C41.1404%200%2044.5817%203.39646%2044.5817%207.58621V32.104C44.5817%2036.4386%2039.0241%2038.3197%2036.3287%2034.8976L27.902%2024.1991V37.1724C27.902%2040.9432%2024.8048%2044%2020.9842%2044H7.68651C3.44137%2044%200%2040.6035%200%2036.4138V7.58621ZM7.68651%206.06897C6.83748%206.06897%206.14921%206.74826%206.14921%207.58621V36.4138C6.14921%2037.2517%206.83748%2037.931%207.68651%2037.931H21.2148C21.6393%2037.931%2021.7528%2037.5914%2021.7528%2037.1724V19.7752C21.7528%2015.4407%2027.3104%2013.5594%2030.0059%2016.9816L38.4325%2027.6801V7.58621C38.4325%206.74826%2038.5129%206.06897%2037.6639%206.06897H7.68651Z&#x27;%20fill=&#x27;url(%23paint1_linear_8138_23)&#x27;%20fill-opacity=&#x27;0.35&#x27;/%3e%3cpath%20d=&#x27;M36.8954%200C41.1406%200%2044.5819%203.39646%2044.5819%207.58621V32.104C44.5819%2036.4386%2039.0243%2038.3197%2036.3289%2034.8976L27.9022%2024.1991V37.1724C27.9022%2040.9432%2024.805%2044%2020.9844%2044C21.4089%2044%2021.753%2043.6604%2021.753%2043.2414V19.7752C21.753%2015.4407%2027.3106%2013.5594%2030.0061%2016.9816L38.4327%2027.6801V1.51724C38.4327%200.679292%2037.7445%200%2036.8954%200Z&#x27;%20fill=&#x27;%2363F655&#x27;/%3e%3cpath%20d=&#x27;M75.1561%2012.9622V24.4706L63.8496%2012.9622H57.9648V31.7844H63.332V19.4155L75.6465%2031.7844H80.5232V12.9622H75.1561Z&#x27;%20fill=&#x27;%231A1A1A&#x27;/%3e%3cpath%20d=&#x27;M90.4724%2027.5898V24.2555H102.487V20.2491H90.4724V17.1569H105.048V12.9622H84.9963V31.7844H105.348V27.5898H90.4724Z&#x27;%20fill=&#x27;%231A1A1A&#x27;/%3e%3cpath%20d=&#x27;M119.61%2032.4029C127.157%2032.4029%20132.061%2028.746%20132.061%2022.3733C132.061%2016.0006%20127.157%2012.3438%20119.61%2012.3438C112.063%2012.3438%20107.187%2016.0006%20107.187%2022.3733C107.187%2028.746%20112.063%2032.4029%20119.61%2032.4029ZM119.61%2027.9393C115.415%2027.9393%20112.826%2025.9226%20112.826%2022.3733C112.826%2018.824%20115.442%2016.8073%20119.61%2016.8073C123.806%2016.8073%20126.394%2018.824%20126.394%2022.3733C126.394%2025.9226%20123.806%2027.9393%20119.61%2027.9393Z&#x27;%20fill=&#x27;%231A1A1A&#x27;/%3e%3cpath%20d=&#x27;M152.632%2012.9622V24.4706L141.326%2012.9622H135.441V31.7844H140.808V19.4155L153.123%2031.7844H157.999V12.9622H152.632Z&#x27;%20fill=&#x27;%231A1A1A&#x27;/%3e%3c/g%3e%3cdefs%3e%3clinearGradient%20id=&#x27;paint0_linear_8138_23&#x27;%20x1=&#x27;44.5818&#x27;%20y1=&#x27;44&#x27;%20x2=&#x27;5.96033&#x27;%20y2=&#x27;-0.503114&#x27;%20gradientUnits=&#x27;userSpaceOnUse&#x27;%3e%3cstop%20stop-color=&#x27;%232EF51C&#x27;/%3e%3cstop%20offset=&#x27;1&#x27;%20stop-color=&#x27;%232EF51C&#x27;%20stop-opacity=&#x27;0&#x27;/%3e%3c/linearGradient%3e%3clinearGradient%20id=&#x27;paint1_linear_8138_23&#x27;%20x1=&#x27;44.5817&#x27;%20y1=&#x27;44&#x27;%20x2=&#x27;18.194&#x27;%20y2=&#x27;33.6003&#x27;%20gradientUnits=&#x27;userSpaceOnUse&#x27;%3e%3cstop%20stop-opacity=&#x27;0.9&#x27;/%3e%3cstop%20offset=&#x27;1&#x27;%20stop-color=&#x27;%231A1A1A&#x27;%20stop-opacity=&#x27;0&#x27;/%3e%3c/linearGradient%3e%3cclipPath%20id=&#x27;clip0_8138_23&#x27;%3e%3crect%20width=&#x27;158&#x27;%20height=&#x27;44&#x27;%20fill=&#x27;white&#x27;/%3e%3c/clipPath%3e%3c/defs%3e%3c/svg%3e)    &#x27;/%3e%3c/svg%3e)       

**Query** ** ** ** You?**

We're looking for TanStack Query Partners to join our mission! Partner with us to push the boundaries of TanStack Query and build amazing things together.

**Let's chat**

**View Previous Partners**

## **Built with TanStack Query**

See how developers are using this library



### **Sponsors**

**Become a Sponsor**

**Wow, you've come a long way!**

*Only one thing left to do...*

**Read the Docs!**

Blog

@Tan_Stack on X.com

@TannerLinsley on X.com

GitHub

YouTube

Nozzle.io - Keyword Rank Tracker

Ethos

Tenets

Privacy Policy

Terms of Service

 2026 TanStack LLC