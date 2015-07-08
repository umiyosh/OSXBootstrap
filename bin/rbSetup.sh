#!/usr/bin/env bash

\curl -sSL https://get.rvm.io | bash -s stable

# ruby-gem
# TODO: 妥当なPATHの解決
rvm install ruby-2.0.0-p576
rvm use ruby-2.0.0-p576
cat ./rubyPackages | while read package
do
  gem install $package
done

