#!/usr/bin/env bash
# shellcheck disable=SC1090

__spalger_dotfiles__() {
  unset __spalger_dotfiles__

  main() {
    setup_aliases
    setup_bash_completion
    setup_brew
    setup_env
    # setup_java
    setup_node
    setup_bun
    setup_go
    # setup_rust
    # setup_ruby
    setup_ps1
    setup_gcloud
    setup_pyenv

    export HISTCONTROL=ignoredups
  }

  setup_gcloud() {
    source "$HOME/google-cloud-sdk/path.bash.inc"
    source "$HOME/google-cloud-sdk/completion.bash.inc"
  }

  setup_aliases() {
    source ~/.dotfiles/aliases.sh

    if [ -f ~/.aliases ]; then
      source ~/.aliases
    else
      echo "NO .aliases"
    fi
  }

  setup_bash_completion() {
    . "/opt/homebrew/etc/profile.d/bash_completion.sh"
  }

  setup_brew() {
    eval "$(/opt/homebrew/bin/brew shellenv)"
  }

  setup_env() {
    export EDITOR=vim

    export PATH="$HOME/bin:$PATH"
    export PATH="$HOME/.dotfiles/bin:$PATH"

    if [ -f "$HOME/.include.env" ]; then
      source "$HOME/.include.env"
    fi
  }

  setup_java() {
    export JABBA_HOME="$HOME/.jabba"
    source "$JABBA_HOME/jabba.sh"
  }

  setup_go() {
    export GOROOT="/usr/local/go"
    export GOPATH="$HOME/go"
  }

  setup_rust() {
    source $HOME/.cargo/env
  }

  setup_ruby() {
    eval "$(rbenv init -)"
  }

  setup_node() {
    # setup node version manager
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh" # This loads nvm
    source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  }

  setup_bun() {
    BUN_INSTALL="$HOME/.bun"
    PATH="$BUN_INSTALL/bin:$PATH"
  }

  setup_ps1() {
    export GITAWAREPROMPT="$HOME/.dotfiles/repos/git-aware-prompt"
    source "$GITAWAREPROMPT/main.sh"
    # shellcheck disable=SC2154
    export PS1="\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\] \$ "
  }

  setup_pyenv() {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
  }

  main
}

__spalger_dotfiles__