#!/bin/bash

#Use pandoc to create html page from markdown report.md
pandoc report.md -s -c pandoc.css -o index.html --smart

#Commit changes and push them to github
git add --all
git commit -m "newest update"
git push

#Update gh-pages to match master branch
git checkout gh-pages
git rebase master
git push origin gh-pages
git checkout master
