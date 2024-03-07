#!/usr/bin/env bash

PYVERSION=$(python -V | awk '{print $2}' | cut -d'.' -f1,2)
CUR=$(pwd)
cd ~
python -m venv python_v${PYVERSION}
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

