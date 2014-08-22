#!/bin/bash
export DEV_ROOT=$HOME/code

####
##
#   EXTEND $PATH
##
####
export PATH=./node_modules/.bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH="$PATH:/usr/local/heroku/bin"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

####
##
#   INCLUDE SOME ENV SPECIFIC CONFIGS
##
####
sources=(
  "$HOME/.bash_profiles/go"
  "$HOME/.bash_profiles/java"
  "$HOME/.bash_profiles/git-completion"
  "$HOME/.bash_profiles/ps1"
  "$HOME/.bash_profiles/aliases"

  "$HOME/.nvm/nvm.sh"
  # "$HOME/.bash_profiles/mongo/mongo"
  # "$HOME/.rvm/scripts/rvm"
  # "$HOME/.travis/travis.sh"
)

for i in "${sources[@]}"
do
  source "$i"
done