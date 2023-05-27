#!/usr/bin/env bash

# keyboard
defaults write NSGlobalDomain KeyRepeat -int   2 # キーリピート速度
defaults write NSGlobalDomain InitialKeyRepeat -int 15 # キーリピート開始までの時間
defaults write -g com.apple.keyboard.fnState -boolean true # activate function key

# animation off
defaults write com.apple.dock expose-animation-duration -float 0.1 ; killall Dock
chflags nohidden ~/Library/
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO; killall Dock
defaults write com.apple.dock workspaces-edge-delay -float 0;killall Dock

# finder settings
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
defaults write com.apple.Finder AppleShowAllFiles YES
defaults write com.apple.finder QLEnableTextSelection -bool true # QuickLook時に文字をコピペ可能にする
killall Finder

# plist restore
if [[ ! -e $HOME/Dropbox/Mackup/.mackup.cfg ]]; then
  ln -s $HOME/dotfiles/.mackup.cfg $HOME/Dropbox/Mackup/.mackup.cfg
fi

mackup restore

# karabiner setting
if [[ ! -d $HOME/Library/Application\ Support/KeyRemap4MacBook ]]; then
  git clone https://github.com/umiyosh/KeyRemap4MacBook-private-xml.git $HOME/Library/Application\ Support/KeyRemap4MacBook
fi

if [[ ! -d $HOME/bin ]]; then
  ln -s $HOME/Dropbox/bin $HOME/bin
fi

if [[ ! -d $HOME/lib ]]; then
  ln -s $HOME/Dropbox/lib $HOME/lib
fi

