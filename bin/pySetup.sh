#!/usr/bin/env bash

# python-pip
# TODO: 妥当なPATHの解決
pyenv virtualenv --distribute 2.7.12 sandbox2712
pyenv install 2.7.12
pyenv global sandbox2712
pip install -r ./pythonPackages

curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
cat ./pipsiPackages | while read package
do
  pipsi install $package
done
