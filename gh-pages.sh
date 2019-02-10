#!/bin/bash

git checkout -B gh-pages master
git fetch origin example-table
git fetch origin nav-active-link
git merge --no-edit origin/example-table origin/nav-active-link
git rm CNAME
git commit -m"rm CNAME"
sed -i "" -e '/^baseurl:/ s/""/"\/pixyll"/' _config.yml
git add _config.yml
git commit -m"baseurl: /pixyll"
