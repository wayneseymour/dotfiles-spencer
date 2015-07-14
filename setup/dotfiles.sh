#!/usr/bin/env bash

# clone the repo or update it
if [ ! -d ~/.dotfiles ]; then
  info 'cloning all .dotfiles to ~/.dotfiles'
  git clone https://github.com/spalger/dotfiles.git ~/.dotfiles
  cd ~/.dotfiles

  ln -s ~/.dotfiles/.bash_profile ~/.bash_profile
  ln -s ~/.dotfiles/.bashrc ~/.bashrc
  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
else
  info 'updating .dotfiles repo'
  cd ~/.dotfiles
  git fetch origin master
  git reset --hard origin/master
  git clean -fd
fi