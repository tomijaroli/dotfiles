#!/bin/bash

# Linux-specific exports

export BROWSER="brave"

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

# Neovim bob package manager
if [ -d "$HOME/.local/share/bob/nightly/bin" ]; then
    export PATH="$PATH:$HOME/.local/share/bob/nightly/bin"
fi

# Nvm (Linux standard path)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Add local bin if not already added
export PATH="$HOME/.local/bin:$PATH"

eval "$(dircolors ~/.dircolors)"
export EXA_COLORS=$LS_COLORS

