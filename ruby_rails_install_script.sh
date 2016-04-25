#!/bin/bash
# script for installing new ruby, rails and mysql client application and gem
 
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev -y

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

rbenv install -v 2.2.3
rbenv global 2.2.3

echo "gem: --no-document" > ~/.gemrc

gem install bundler
gem install rails

rbenv rehash

ruby -v
rails -v

sudo apt-get install mysql-client libmysqlclient-dev -y

gem install mysql2


