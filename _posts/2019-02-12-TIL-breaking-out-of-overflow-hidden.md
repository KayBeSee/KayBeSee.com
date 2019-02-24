---
layout: post
title: Breaking Out of Overflow Hidden
date: 12-02-2019 18:21:57
categories: ['TIL']
---

I ran into a problem at work today where I needed to create a popover menu that needed to "break out" of its container that had `overflow: hidden` on it.

Turns out it's actually kind of simple in the right conditions.

Simply move the container with `position: relative` to _above_ the `overflow: hidden` div in the tree.

Source: http://front-back.com/how-to-make-absolute-positioned-elements-overlap-their-overflow-hidden-parent