#!/bin/bash

# Linux-specific exports

export BROWSER="firefox"

# Neovim bob package manager
if [ -d "$HOME/.local/share/bob/nightly/bin" ]; then
    export PATH="$PATH:$HOME/.local/share/bob/nightly/bin"
fi

# Nvm (Linux standard path)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Android (Linux path)
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
fi

# Add local bin if not already added
export PATH="$HOME/.local/bin:$PATH"
