#!/usr/bin/env bash

# TODO: 妥当なPATHの解決
rbenv install 3.4.4
rbenv global 3.4.4
rbenv rehash
cat ./rubyPackages | while read package
do
  gem install $package
done

