#!/bin/sh
set -e

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo `date` >> forcebuild.date
git add -A -f dist/**
git commit -m 'Deploy to GitHub Pages' 
git push