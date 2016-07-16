#!/usr/bin/env bash

if [[ ! -d $HOME/.nodebrew ]]; then
  mkdir -p $HOME/.nodebrew/src
fi

# node-npm
nodebrew install latest
nodebrew use latest
cat ./nodePackages | while read package
do
  npm install -g $package
done

