#!/bin/sh

echo "Deploying!"
npm run prod
cd public
git init
git add .
git commit -m "Deploy at $(date)."
git push --force origin gh-pages
