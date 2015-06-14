#!/bin/bash

#Use pandoc to create html page from markdown report.md
pandoc report.md -s -c pandoc.css -o index.html

#Commit changes and push them to github
#git add --all
#git commit -m "newest update"
#git push

#Update the gh-pages branch to match the master
#git checkout gh-pages
#git rebase master
#git push origin gh-pages
#git checkout master
