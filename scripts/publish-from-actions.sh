#!/bin/sh
set -e

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo `date` >> forcebuild.date
git add -A -f dist/**
git commit -m 'Deploy to GitHub Pages' 
git push