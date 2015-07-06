#!/usr/bin/env bash

# perl-cpanm
# TODO: 妥当なPATHの解決
curl -L https://cpanmin.us | perl - --sudo App::cpanminus
cat ./perlPackages | while read package
do
  cpanm $package
done
