---
number: 206
title: How to use like Layer two elements
category: "Q&A"
created: 2024-06-26
url: "https://github.com/vueuse/motion/discussions/206"
upvotes: 1
comments: 0
answered: false
---

# How to use like Layer two elements



https://github.com/vueuse/motion/assets/12596485/68b5580e-8f5d-4ccc-8699-21499396c740


react like:

```tsx
import { motion } from "framer-motion";
import { useState } from "react";
 
export default function Example() {
  const [showSecond, setShowSecond] = useState(false);
 
  return (
    <div className="wrapper">
      <motion.button layout className="button" onClick={() => setShowSecond((s) => !s)}>
        Animate
      </motion.button>
      {showSecond ? (
        <motion.div layoutId="rectangle" className="second-element" style={{ borderRadius: 12 }} />
      ) : (
        <motion.div layoutId="rectangle" className="element" style={{ borderRadius: 12 }} />
      )}
    </div>
  );
}
```

my buggy example: 

...