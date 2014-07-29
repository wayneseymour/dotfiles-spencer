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
#   ES Version Manager config
##
####
export ES_VERSIONS=$HOME/.esvm
export ES_DEFAULT_REF='master'

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

  "$HOME/.esvm/esvm.sh"
  "$HOME/.nvm/nvm.sh"
  # "$HOME/.rvm/scripts/rvm"
  # "$HOME/.travis/travis.sh"
)

for i in "${sources[@]}"
do
  source "$i"
done