#!/usr/bin/env bash

__spalger_dotfiles__() {
  unset __spalger_dotfiles__
  
  main() {
    setup_aliases
    setup_bash_completion
    setup_env
    setup_iterm
    setup_java
    setup_rust
    setup_node
    setup_ps1
  }
  
  setup_aliases() {
    if [ -f ~/.aliases ]; then
      source ~/.aliases
    fi

    alias gut=git;
    alias gti=git;
    alias got=git;
    alias "atom-"='tmpin atom';
    alias ll='ls -1AhH';
    alias dock='eval "$(docker-machine env)"';
  }

  setup_bash_completion() {
    if [ -f /usr/local/etc/bash_completion ]; then
      . /usr/local/etc/bash_completion
    fi
  }

  setup_env() {
    export EDITOR=vim
    
    export PATH=./bin:$PATH
    export PATH=$HOME/bin:$PATH
    export PATH=$HOME/.dotfiles/bin:$PATH
    export PATH=/usr/local/sbin:$PATH
    export PATH=/usr/local/bin:$PATH
  }

  setup_iterm() {
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
  }

  setup_java() {
    [ -s "${HOME}/.jabba/jabba.sh" ] && source "${HOME}/.jabba/jabba.sh"
  }
  
  setup_rust() {
    [ -s "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"
  }

  setup_node() {
    # setup node version manager
    export NVM_DIR="$HOME/.nvm"
    [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm

    # setup automatic node version switching
    [[ -s "${HOME}/.avn/bin/avn.sh" ]] && source "${HOME}/.avn/bin/avn.sh" # load avn
  }

  setup_ps1() {
    export CLICOLOR=1

    c_red=$(tput setaf 1)
    c_green=$(tput setaf 2)
    c_sgr0=$(tput sgr0)

    parse_git_branch (){
      if git rev-parse --git-dir >/dev/null 2>&1
      then
          gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
      else
          return 0
      fi

      status="[$(branch_color)${gitver}${c_sgr0}]"

      git_stash="$(git stash list 2> /dev/null)"
      if [[ ! ${#git_stash} -eq 0 ]]; then
          status="${status} ☢"
      fi

      echo -e "${status} "
    }

    branch_color (){
      if git rev-parse --git-dir >/dev/null 2>&1
      then
          color=""
      if git diff --quiet 2>/dev/null >&2
      then
          color="${c_green}"
      else
          color=${c_red}
      fi
      else
          return 0
      fi
      echo -ne "${color}"
    }

    # shellcheck disable=2016
    export PS1='\W $(parse_git_branch)\$ '
  }
  
  main
}

__spalger_dotfiles__