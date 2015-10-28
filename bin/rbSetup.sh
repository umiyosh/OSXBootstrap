#!/usr/bin/env bash

# TODO: 妥当なPATHの解決
cat ./rubyPackages | while read package
do
  gem install $package
done

