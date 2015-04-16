#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."

set -e

# Ask for the administrator password upfront
sudo -v


info () {
  printf "  [ \033[00;34m..\033[0m ] %s" "$1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] %s" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n\n" "$1"
  exit
}

info "here we go"
info "setting up git"
user 'What is your github username?'
read -e github_username

info "run: git config --global user.name \"${github_username}\""
info "run: git config --global user.email \"${github_username}@users.noreply.github.com\""
success 'git/github setup'

# If we're on a Mac, let's install and setup homebrew.
if [ "$(uname -s)" == "Darwin" ]; then
  info "setting up OSX"
  # ./install/osx.sh
  success "Done! Please restart for all changes to take effect."
fi