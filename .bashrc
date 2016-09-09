#!/usr/bin/env bash

####
##
#   INCLUDE SOME ENV SPECIFIC CONFIGS
##
####
sources=(
  "$HOME/.dotfiles/lib/aliases"
  "$HOME/.dotfiles/lib/bash_completion"
  "$HOME/.dotfiles/lib/env"
  "$HOME/.dotfiles/lib/java"
  "$HOME/.dotfiles/lib/node"
  "$HOME/.dotfiles/lib/path"
  "$HOME/.dotfiles/lib/ps1"
)

for i in "${sources[@]}"
do
  source "$i"
done
