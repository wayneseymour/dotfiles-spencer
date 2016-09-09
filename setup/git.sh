#!/usr/bin/env bash

username="$(whoami)"

git config --global user.name "${username}"
git config --global user.email "${username}@users.noreply.github.com"
git config --global credential.helper osxkeychain
