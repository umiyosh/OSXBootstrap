#!/usr/bin/env bash

CUR=$(pwd)
cd ~
python -m venv python_v3.9
cd $CUR
export PATH=~/.local/bin:$PATH
source ~/python_v3.9/bin/activate

cat ./pipsiPackages | while read package
do
  # brew install pipx or install via brewfile
  pipx install $package
done
