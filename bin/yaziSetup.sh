#!/usr/bin/env bash

YAZI_CONFIG_DIR=~/.config/yazi_config
YAZI_REPO=https://github.com/umiyosh/yazi_config.git

if [[ ! -d $YAZI_CONFIG_DIR ]]; then
  git clone $YAZI_REPO $YAZI_CONFIG_DIR
else
  cd $YAZI_CONFIG_DIR
  git pull origin master
fi

cd $YAZI_CONFIG_DIR
make deploy

# プラグインインストール
ya pack -a Gallardo994/clippy
