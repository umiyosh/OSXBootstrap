#!/usr/bin/env zsh

workdir=$(pwd)

# Brewfile
git clone https://github.com/umiyosh/Brewfile.git ~/Brewfile/
cd ~/Brewfile/
./brewSetup.sh
cd $workdir
read -q "Check Result.And press Enter key"

# Dotfile
git clone https://github.com/umiyosh/dotfiles.git ~/dotfiles/
cd ~/dotfiles/
./setup.sh
cd $workdir

# zsh plugin install by antigen
zsh

# wait the sync of Dropbox
read -q "Wait until the sync of Dropbox is finished.And press Enter."

# OSX setting and Programing Lunguage seting up
./bin/misc.sh
./bin/pySetup.sh
brew install rcmdnk/file/brew-file
brew file set_repo
./bin/goSetup.sh
./bin/nodeSetup.sh
./bin/plSetup.sh
./bin/rbSetup.sh
