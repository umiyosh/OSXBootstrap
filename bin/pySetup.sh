#!/usr/bin/env bash

python -m venv python_v3.9
export PATH=~/.local/bin:$PATH
source ~/python_v3.9/bin/activate

curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
cat ./pipsiPackages | while read package
do
  pipsi install $package
done
