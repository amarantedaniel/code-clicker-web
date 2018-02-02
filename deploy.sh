#!/bin/sh

npm run build
g branch -D gh-pages
g co -b gh-pages
mv public/* .
g add .
g commit -m "deploy"
g pb
