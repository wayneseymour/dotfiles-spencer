#!/usr/bin/env bash

info "installing a recent version of ruby"
ruby_version='2.2.2'
rbenv install "$ruby_version"
rbenv global "$ruby_version"
rbenv rehash
