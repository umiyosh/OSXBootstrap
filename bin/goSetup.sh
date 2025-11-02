#!/usr/bin/env bash

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source $HOME/.gvm/scripts/gvm

gvm install go1.25.3
gvm use go1.25.3 --default

# TODO: 開発環境回りsetup
cat ./goPackages | while read package
do
  go install $package
done

