#!/usr/bin/sh

# quit deployment right away if something fails
set -e

DEPLOY_DIR=public
OK="[\033[0;32mOK\033[0m]\n"

if [ $# -ne 1 ]; then
    echo "Usage: ./deploy.sh COMMIT_MESSAGE"
    exit 1
fi

echo "=== Deploying website to GitHub ==="

echo "[Clearing publish dir]"
rm -rf $DEPLOY_DIR/*
printf $OK

echo "[Rebuilding website]"
hugo
printf $OK

cd $DEPLOY_DIR

echo "[Committing new website]"
git add .
git commit -m "$1"
printf $OK

echo "[Pushing to GitHub]"
printf "Are you sure (y/n)? "
read ANSWER
if [ "$ANSWER" != "y" ]; then
    echo "ABORTING"
    exit 1
fi
git push origin master
printf $OK

echo "SUCCESS!!!"

