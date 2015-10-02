#!/usr/bin/env bash

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source $HOME/.gvm/scripts/gvm

gvm install go1.5
gvm use go1.5 --default

# go-get
# TODO: 開発環境回りsetup
cat ./goPackages | while read package
do
  go get $package
done
