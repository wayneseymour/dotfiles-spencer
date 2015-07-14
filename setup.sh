#!/usr/bin/env bash

###############################################################################
# bootstrap a new OSX box                                                     #
###############################################################################

set -e

info () {
  printf "  [ \033[00;34m..\033[0m ] %s\n" "$1"
}
user () {
  printf "  [ \033[0;33m?\033[0m ] %s: " "$1"
}
line () {
  printf "\n        %s" "$1"
}
success () {
  printf "\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}
fail () {
  printf "\033[2K  [\033[0;31mFAIL\033[0m] %s\n\n" "$1"
  exit
}


# We currently only support OSX
if [ "$(uname -s)" != "Darwin" ]; then
  fail 'Sorry, get a mac please.'
fi

info 'Lets get setup!'
info 'are you ready? Hit enter to begin'
read -e

# info ""
# Ask for the administrator password upfront
sudo -p '  [ \033[0;33m?\033[0m ] What is your admin password? (characters are invisible)' -v

user 'What is your github username?'
read -e usrname

source ./setup/ssh.sh;
source ./setup/brew.sh;
source ./setup/git.sh;
source ./setup/dotfiles.sh;
source ./setup/brew-base-apps.sh;
source ./setup/node.sh;
source ./setup/ruby.sh;
source ./setup/osx.sh;

success "Done! Please restart for all changes to take effect."