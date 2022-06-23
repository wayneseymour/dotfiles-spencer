#!/usr/bin/env bash

alias gut=git;
alias gti=git;
alias got=git;
alias kbs="yarn kbn bootstrap"
alias kbsf="yarn kbn bootstrap && yarn kbn run build -i @kbn/pm"
alias kbn-nuke="git clean -fdx -e /config -e /.vscode -e /.bazelrc.cache"
alias kbp="cd ~/.backport/repositories/elastic/kibana"
alias pum="git pum"
alias nps="node --preserve-symlinks --preserve-symlinks-main"
alias npi="nps --inspect-brk"

function kbn {
  branch="${1:-main}"
  dir="$HOME/kbn-dev/$branch/kibana"
  
  if [ -d "$dir" ]; then
    cd "$dir" || return 1
  else
    git clone git@github.com:elastic/kibana.git --branch "$branch" "$dir"  || return 1
    cd "$dir" || return 1
    git remote rename origin upstream
    git remote add origin git@github.com:spalger/kibana.git
  fi
}
