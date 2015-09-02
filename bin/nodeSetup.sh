#!/usr/bin/env bash

# node-npm
nodebrew install latest
nodebrew use latest
cat ./nodePackages | while read package
do
  npm install -g $package
done

