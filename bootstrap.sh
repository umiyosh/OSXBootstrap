#!/usr/bin/env zsh

workdir=$(pwd)

# Brewfile
if [[ ! -d ~/Brewfile/ ]]; then
  git clone https://github.com/umiyosh/Brewfile.git ~/Brewfile/
else
  cd ~/Brewfile/
  git pull origin master
fi
cd ~/Brewfile/
./brewSetup.sh
cd $workdir
read -q "REP?Check Result.if result is ok, Press Y/y, if you want to cancle press ctrl+c."

# Dotfile
if [[ ! -d  ~/dotfiles/ ]]; then
  git clone https://github.com/umiyosh/dotfiles.git ~/dotfiles/
else
  cd ~/dotfiles/
  git pull origin master
fi
cd ~/dotfiles/
./setup.sh
cd $workdir

# wait the sync of Dropbox
read -q "REP?Wait until the sync of Dropbox is finished.if the sync is ok, Press Y/y, if you want to cancle press ctrl+c."

# OSX setting and Programing Lunguage seting up
./bin/misc.sh
./bin/pySetup.sh
brew install rcmdnk/file/brew-file
brew file set_repo
./bin/goSetup.sh
./bin/nodeSetup.sh
./bin/plSetup.sh
./bin/rbSetup.sh

# mvim
wget http://repo.or.cz/w/MacVim/KaoriYa.git/blob_plain/HEAD:/src/MacVim/mvim
sudo mv /usr/bin/vim /usr/bin/vim.$(date +"%Y%m%d%H%M")
sudo mv mvim /usr/bin/vim
sudo chmod +x /usr/bin/vim
