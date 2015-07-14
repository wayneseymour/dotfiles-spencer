#!/usr/bin/env bash

ruby_version='2.2.2'

info "installing a recent version of ruby"
rbenv install "$ruby_version"
rbenv global "$ruby_version"
rbenv rehash

info "installing the travis toolbelt"
gem install travis
