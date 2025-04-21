#!/bin/sh
git pull
git add *
read -p 'Commit Message: ' commitMessage
git commit -m "$commitMessage"
read -p 'Branch: ' branchName
git push -u origin $branchName
