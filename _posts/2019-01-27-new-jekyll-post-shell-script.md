---
layout: post
title: New Jekyll Post Shell Script
date: 27-01-2019 20:40:19
categories:
---

One of the biggest pains about this new Jekyll blog is having to create a new post file for every new post that I want to make. 

It's really not _that_ big of a deal, but my current method of copying and pasting an old post and then replacing all the variables seems rudimentary. Plus I know that I am not formatting the dates correctly, especially on smaller posts because they aren't worth the time.

So tonight I automated that with a shell script that creates a new markdown file based on a string that I type into the terminal.


### The Code

```
#!/bin/bash

echo -n "Post Title: "
read RAW_TITLE

FILE_FORMAT_TITLE=`echo $RAW_TITLE | tr '[:upper:]' '[:lower:]'`

FILE_FORMAT_TITLE=`echo ${FILE_FORMAT_TITLE// /-}`
DATE=`date +%Y-%m-%d`
FRONT_MATTER_DATE=$(date +%d-%m-%Y" "%H:%M:%S)

touch "_posts/$DATE-$FILE_FORMAT_TITLE.md"

echo ---                              >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo layout: post                     >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo title:  "$RAW_TITLE"             >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo date:   $FRONT_MATTER_DATE       >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo categories:                      >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo ---                              >> _posts/$DATE-$FILE_FORMAT_TITLE.md
```

### Some future improvements:
 - ask for categories
 - better draft / publish functionality 
      - start as draft with timestamp
      - then another command to publish with timestamp