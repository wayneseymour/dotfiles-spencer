#!/bin/bash
if [ "$(uname -s)" != "Darwin" ]; then
  echo 'the bootstrap script only supports OSX'
  exit 1
fi

[ -z "$(which brew)" ] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
[ -z "$(which git)" ] && brew install git

git clone https://github.com/spalger/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install/install.sh