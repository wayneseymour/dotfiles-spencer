#!/usr/bin/env bash

info "installing nvm"
git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags` && cd -

info "installing node.js"
nvm install 4
nvm alias default 4

info "installing node auto-switching"
npm install -g avn avn-nvm
