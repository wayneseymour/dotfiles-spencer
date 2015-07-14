#!/usr/bin/env bash

export DEV_ROOT=$HOME/dev

####
##
#   EXTEND $PATH
##
####
export PATH=$HOME/.pear/bin:$PATH
export PATH=$HOME/.dotfiles/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH

####
##
#   INCLUDE SOME ENV SPECIFIC CONFIGS
##
####
sources=(
  "$HOME/.dotfiles/lib/aliases"

  "$HOME/.dotfiles/lib/ps1"
  "$HOME/.dotfiles/lib/node"

  "$HOME/.dotfiles/lib/git"
  "$HOME/.dotfiles/lib/java"
  "$HOME/.dotfiles/lib/ruby"
  "$HOME/.dotfiles/lib/docker"
  "$HOME/.dotfiles/lib/rust"
  "$HOME/.dotfiles/lib/go"
  "$HOME/.dotfiles/lib/mongo/mongod"
)

for i in "${sources[@]}"
do
  source "$i"
done
# added by travis gem
[ -f /Users/spalger/.travis/travis.sh ] && source /Users/spalger/.travis/travis.sh
