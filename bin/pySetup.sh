#!/usr/bin/env bash

export PATH="/usr/local/opt/python/libexec/bin:$PATH"
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi

pip install -r ./pythonPackages
mkvirtualenv py2.7-global --python=python2.7
workon py2.7-global
pip install -r ./pythonPackages
mkvirtualenv py3.6-global --python=python3.6
workon py3.6-global
pip install -r ./pythonPackages

curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
cat ./pipsiPackages | while read package
do
  pipsi install $package
done
