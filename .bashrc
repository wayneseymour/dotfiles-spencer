#!/usr/bin/env bash
# shellcheck disable=SC1090

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
    setup_go
    setup_ps1
    setup_sdkman
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
    source "${HOME}/.iterm2_shell_integration.bash"
  }

  setup_java() {
    source "${HOME}/.jabba/jabba.sh"
  }
  
  setup_rust() {
    source "${HOME}/.cargo/env"
  }
  
  setup_go() {
    export GOPATH="${HOME}/gopath"
  }

  setup_node() {
    # setup node version manager
    export NVM_DIR="$HOME/.nvm"
    source "${NVM_DIR}/nvm.sh"  # This loads nvm
    
    # add yarn globals to path
    export PATH="$HOME/.yarn/bin:$PATH"

    # setup automatic node version switching
    source "${HOME}/.avn/bin/avn.sh" # load avn
  }
  
  setup_sdkman() {
    #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
    export SDKMAN_DIR="${HOME}/.sdkman"
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
  }

  setup_ps1() {
    export GITAWAREPROMPT="${HOME}/.dotfiles/repos/git-aware-prompt"
    source "${GITAWAREPROMPT}/main.sh"
    export PS1="\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] \$ "
  }
  
  main
}

__spalger_dotfiles__