#!/usr/bin/env bash

if [ -z "$(which brew)" ]; then
  info 'installing brew'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

info 'updating brew'
brew update