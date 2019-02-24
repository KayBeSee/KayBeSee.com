---
layout: post
title: TIL - Git Reset
date: 12-02-2019 18:19:44
categories: ['TIL']
---

TIL to undo a commit but keep the working files, do `git reset HEAD^`.

To undo a commit and delete the files, do `git reset --hard HEAD^`.

Source: https://sethrobertson.github.io/GitFixUm/fixup.html#remove_last