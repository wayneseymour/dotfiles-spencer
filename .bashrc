#!/bin/bash
export DEV_ROOT=$HOME/dev

####
##
#   EXTEND $PATH
##
####
export PATH=./node_modules/.bin:$PATH
export PATH=$DEV_ROOT/dotfiles/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/local/heroku/bin" ### Added by the Heroku Toolbelt

####
##
#   INCLUDE SOME ENV SPECIFIC CONFIGS
##
####
sources=(
  "$HOME/.nvm/nvm.sh"
  "$HOME/.avn/bin/avn.sh"
  "$HOME/.travis/travis.sh"

  "$HOME/.bash_profiles/go"
  "$HOME/.bash_profiles/git"
  "$HOME/.bash_profiles/java"
  "$HOME/.bash_profiles/ruby"
  "$HOME/.bash_profiles/rust"
  "$HOME/.bash_profiles/ps1"
  "$HOME/.bash_profiles/aliases"
  "$HOME/.bash_profiles/mongo/mongod"
  "$HOME/.bash_profiles/docker"
)

for i in "${sources[@]}"
do
  source "$i"
done