#!/bin/bash

#Use pandoc to create html page from markdown report.md
pandoc report.md -s -c pandoc.css -o mla_data.html

cp mla_data.html ~/aaronbev79.github.io

#Commit changes and push them to github
#git add --all
#git commit -m "newest update"
#git push
