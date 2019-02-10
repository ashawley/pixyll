#!/bin/bash

set -xe

# rbenv shell 2.4.0

# gem install --no-ri --no-rdoc bundler jekyll

gem build pixyll.gemspec

bundle exec jekyll new pixyll-quickstart

mkdir pixyll-quickstart/vendor pixyll-quickstart/vendor/cache

cp -a pixyll-2.10.2.gem pixyll-quickstart/vendor/cache/

cd pixyll-quickstart

git init

echo "Gemfile.lock"  > .gitignore
echo "vendor/"      >> .gitignore
echo "_site/"       >> .gitignore
echo ".sass-cache/" >> .gitignore

git add -A

git commit -m "Initial commit"

sed -i~ -e 's/minima/pixyll/' Gemfile
sed -i~ -e '/the default theme/d' Gemfile

bundle install

sed -i~ -e 's/minima/pixyll/' _config.yml

git add Gemfile _config.yml
git commit -m "Switch to theme, pixyll"

sed -i~ -e '/^gems:/a\
\ \ - jekyll-paginate
' _config.yml

sed -i~ -e '/^plugins:/a\
\ \ - jekyll-paginate
' _config.yml

git add _config.yml
git commit -m "Add jekyll-paginate gem to config"

echo paginate: 1 >> _config.yml

git add _config.yml
git commit -m "Set paginate to 1 in config"

git mv index.md index.html

git add index.html
git commit -m "Move index.md to index.html"

sed -i~ -e 's/base Jekyll theme/Pixyll theme for Jekyll/'       about.md
sed -i~ -e '1,/Minima/ s/Minima/Pixyll/'                        about.md
sed -i~ -e '1,/\[jekyll\]\[jekyll-organization\]/ s/\[jekyll\]\[jekyll-organization\]/johno/' about.md
sed -i~ -e '1,/jekyll\/minima/ s/jekyll\/minima/johno\/pixyll/' about.md
sed -i~ -e '1,/minima/ s/minima/pixyll/'                        about.md

git add about.md
git commit -m "Mention Pixyll on about page"

echo ---                                    > _posts/$(date -u +'%Y-%m-%d')-hello-world.md
echo layout: post                          >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md
echo title: Hello, world                   >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md
echo -n 'date: '                           >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md
echo $(date -u +'%Y-%m-%d %H:%M:%S +0000') >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md
echo ---                                   >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md
echo 'Hello, world!'                       >> _posts/$(date -u '+%Y-%m-%d')-hello-world.md

git add _posts/$(date -u '+%Y-%m-%d')-hello-world.md
git commit -m 'Add "Hello, world" post'

bundle exec jekyll build

grep pixyll _site/index.html
grep post-title _site/index.html
grep pagination-item _site/index.html
grep Newer _site/index.html

git status
