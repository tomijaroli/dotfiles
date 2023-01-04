#!/bin/bash

# History
HISTFILE="$XDG_DATA_HOME"/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="Safari"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init - --path)"
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

nvm use stable

eval "$(zoxide init zsh)"
eval "$(dircolors ~/.nix-profile/share/LS_COLORS)"
