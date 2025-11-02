#!/usr/bin/env bash
PYVERSION=python3.13
PYENV=3.13
CUR=$(pwd)
cd ~
$PYVERSION -m venv python_v${PYENV}
cd $CUR
export PATH=~/.local/bin:$PATH
source ~/python_v${PYVERSION}/bin/activate

cat ./pipsiPackages | while read package
do
  # brew install pipx or install via brewfile
  pipx install $package
done

pip install -r ./pythonPackages

curl -sSf https://rye-up.com/get | bash

