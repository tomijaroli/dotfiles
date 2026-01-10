#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    OS_TYPE="unknown"
fi

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# History
export HISTFILE="$XDG_DATA_HOME"/.bash_history
export HISTSIZE=1000000
export SAVEHIST=1000000

# Editor and Terminal
export EDITOR="nvim"
export TERMINAL="alacritty"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH

# Python
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Ruby
if command -v rbenv &> /dev/null; then
    export RBENV_ROOT="$HOME/.rbenv"
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init - --path)"
    eval "$(rbenv init -)"
fi

# Go
export GOPATH="$HOME/Developer/go"
export PATH="$PATH:$GOPATH/bin"

# Maestro testing
if [ -d "$HOME/.maestro/bin" ]; then
    export PATH=$PATH:$HOME/.maestro/bin
fi

# Zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# Dircolors (use gdircolors on macOS, dircolors on Linux)
if [[ "$OS_TYPE" == "macos" ]] && command -v gdircolors &> /dev/null; then
    eval "$(gdircolors ~/.dircolors)"
    export EXA_COLORS=$LS_COLORS
elif command -v dircolors &> /dev/null; then
    eval "$(dircolors ~/.dircolors)"
    export EXA_COLORS=$LS_COLORS
fi
