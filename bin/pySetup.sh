#!/usr/bin/env bash

# python-pip
CONFIGURE_OPTS="--enable-shared" pyenv install 3.6.3
CONFIGURE_OPTS="--enable-shared" pyenv install 2.7.14
pyenv global sandbox2712
pyenv global 3.6.3 2.7.14
pip install -r ./pythonPackages

curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
cat ./pipsiPackages | while read package
do
  pipsi install $package
done
