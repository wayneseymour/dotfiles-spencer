#!/usr/bin/env bash

info "installing node.js"
nvm install stable
nvm alias default stable

info "installing node auto-switching"
npm install -g avn avn-nvm avn-n