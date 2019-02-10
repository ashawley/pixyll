#!/bin/bash

set -x
set -e

git fetch upstream master
git checkout -B develop upstream/master

git fetch origin default-date-format
git fetch origin forking
git fetch origin site-text-defaults
git fetch origin gemspec

git merge --no-edit default-date-format
git merge --no-edit forking
git merge --no-edit site-text-defaults
git merge --no-edit gemspec
