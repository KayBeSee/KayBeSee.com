---
layout: post
title: Using forwardRef in React
date: 24-02-2019 16:18:52
categories: ['code']
---

I used React's forwardRef the other day at work in order to focus on a input component when our sidebar opens. Without forwardRef, I had a long chain of refs that I was passing down from my parent component, which made a long and ugly reference to target the ref and made the code confusing to read too.

So I was able to turn code that looked like:

```
this.searchBoxRef.current.searchInputRef.current
``` 
into simply:
```
this.searchInput.current
```

Much better!

The code I was working with was only one level deep, so I could see this being expecially useful if you were trying to target a ref three or more levels deep (although, at that point I would consider re-evaluating the structure of the component itself to mitigate needing to reach that far in for a ref).

CodeSandbox mini example:

<iframe src="https://codesandbox.io/embed/w6w16oqppl" style="width:100%; height:500px; border:0; border-radius: 4px; overflow:hidden;" sandbox="allow-modals allow-forms allow-popups allow-scripts allow-same-origin"></iframe>