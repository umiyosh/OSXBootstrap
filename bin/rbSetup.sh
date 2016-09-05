#!/usr/bin/env bash

# TODO: 妥当なPATHの解決
rbenv install 2.2.5
rbenv global 2.2.5
rbenv rehash
cat ./rubyPackages | while read package
do
  gem install $package
done

