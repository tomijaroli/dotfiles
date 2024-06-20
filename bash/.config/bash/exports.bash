#!/bin/bash

# History
export HISTFILE="$HOME"/.bash_history
export HISTSIZE=1000000
export SAVEHIST=1000000

export EDITOR="nvim"
export TERMINAL="alacritty"
if [[ $(uname -m) == "Darwin" ]]; then
    export BROWSER="Safari"
fi
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH

# Homebrew
# Uncomment for macOS
# if [[ $(uname -m) == "Darwin" ]]; then
#     export PATH="/opt/homebrew/bin:$PATH"
#     export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# fi

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Ruby
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init - --path)"
eval "$(rbenv init -)"

# Nvm
# Uncomment for macOS
# if [[ $(uname -m) == "Darwin" ]]; then
#     export NVM_DIR="$HOME/.nvm"
#     [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
#     [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
# fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Android
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/scripts"

# Go
export GOPATH="$HOME/Developer/go"
export PATH="$PATH:$GOPATH/bin"

# Zoxide
eval "$(zoxide init bash)"
eval "$(dircolors ~/.dircolors)"
export EXA_COLORS=$LS_COLORS

export LDFLAGS="-L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/bzip2/include"

eval "$(starship init bash)"
