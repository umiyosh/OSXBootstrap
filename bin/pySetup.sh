#!/usr/bin/env bash

# python-pip
# TODO: 妥当なPATHの解決
pyenv virtualenv --distribute 2.7.8 sandbox278
pyenv install 2.7.8
pyenv local sandbox278
pip install -r ./pythonPackages

