#!/bin/sh
set -e

BUILD_DIR=dist
SOURCE_DIRECTORY_DEPLOY_GH=~/temp-gh-deploy-src
CLONED_DIRECTORY_DEPLOY_GH=~/temp-gh-deploy-cloned
GITHUB_REPOSITORY="awesome-caprover/app-repository"
GITHUB_ACTOR="varunsridharan"
mkdir -p $SOURCE_DIRECTORY_DEPLOY_GH
mkdir -p $CLONED_DIRECTORY_DEPLOY_GH
REMOTE_REPO="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
REPONAME="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 2)"
OWNER="$(echo $GITHUB_REPOSITORY| cut -d'/' -f 1)"
GHIO="${OWNER}.github.io"

if [ "$REPONAME" == "$GHIO" ]; then
  REMOTE_BRANCH="main"
else
  REMOTE_BRANCH="gh-pages"
fi 

sleep 1s
cp -r $BUILD_DIR $SOURCE_DIRECTORY_DEPLOY_GH/
git clone --single-branch --branch=$REMOTE_BRANCH $REMOTE_REPO $CLONED_DIRECTORY_DEPLOY_GH
sleep 1s
cd $CLONED_DIRECTORY_DEPLOY_GH && git rm -rf . && git clean -fdx
sleep 1s
cp -r $SOURCE_DIRECTORY_DEPLOY_GH/$BUILD_DIR $CLONED_DIRECTORY_DEPLOY_GH/$BUILD_DIR
mv $CLONED_DIRECTORY_DEPLOY_GH/.git $CLONED_DIRECTORY_DEPLOY_GH/$BUILD_DIR/ 
cd $CLONED_DIRECTORY_DEPLOY_GH/$BUILD_DIR/ 
sleep 1s
ls -la
sleep 1s
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo `date` >> forcebuild.date
git add -A 
git commit -m 'Deploy to GitHub Pages' 
git push $REMOTE_REPO $REMOTE_BRANCH:$REMOTE_BRANCH 