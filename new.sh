#!/bin/bash

echo -n "Post Title: "
read RAW_TITLE

FILE_FORMAT_TITLE=`echo $RAW_TITLE | tr '[:upper:]' '[:lower:]'`

FILE_FORMAT_TITLE=`echo ${FILE_FORMAT_TITLE// /-}`
DATE=`date +%Y-%m-%d`
FRONT_MATTER_DATE=$(date +%d-%m-%Y" "%H:%M:%S)

touch "_posts/$DATE-$FILE_FORMAT_TITLE.md"

echo ---                                        >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo layout: post                               >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo title:  "$RAW_TITLE"                       >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo date:   $FRONT_MATTER_DATE                 >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo categories:                                >> _posts/$DATE-$FILE_FORMAT_TITLE.md
echo ---                                        >> _posts/$DATE-$FILE_FORMAT_TITLE.md