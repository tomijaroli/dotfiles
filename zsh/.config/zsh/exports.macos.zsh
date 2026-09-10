#!/bin/zsh

# macOS-specific exports

export BROWSER="Safari"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# Nvm (macOS Homebrew path)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Neovim bob package manager
if [ -d "$HOME/.local/share/bob/nightly/bin" ]; then
    export PATH="$PATH:$HOME/.local/share/bob/nightly/bin"
fi

# Android (macOS path)
export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/scripts"

# OrbStack (macOS)
if [ -d "/Applications/OrbStack.app/Contents/MacOS/bin" ]; then
    export PATH="$PATH:/Applications/OrbStack.app/Contents/MacOS/bin"
fi

# iOS module tool (Mint)
if [ -d "$HOME/.mint/bin" ]; then
    export PATH="$PATH:$HOME/.mint/bin"
fi

# SSH Management (Secretive on macOS)
HOST_SHORT="$(hostname -s 2>/dev/null)"
if [[ "$HOST_SHORT" == tomi-woltbook* ]]; then
  export SSH_AUTH_SOCK=/Users/tomi/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
elif [ -S "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
fi
