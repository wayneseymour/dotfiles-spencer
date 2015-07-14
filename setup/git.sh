#!/usr/bin/env bash

info 'setting up git'

if [ -z "$(which git)" ]; then
  info 'installing git'
  brew install git
fi

git config --global user.name "${usrname}"
git config --global user.email "${usrname}@users.noreply.github.com"
git config --global credential.helper osxkeychain
success 'git/github setup'
