#!/usr/bin/env bash

export DEV_ROOT=$HOME/dev

####
##
#   EXTEND $PATH
##
####
export PATH=./bin:$HOME/bin:$HOME/.dotfiles/bin:/usr/local/sbin:/usr/local/bin:$PATH

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
