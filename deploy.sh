#!/bin/sh

npm run build
git push origin :gh-pages  
git branch -D gh-pages
git checkout -b gh-pages
mv public/* .
git add .
git commit -m "deploy"
git push -u origin gh-pages
