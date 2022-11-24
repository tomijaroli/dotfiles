#!/bin/bash

# Options
stty stop undef
unsetopt BEEP

# Load Zap plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# History
HISTFILE=~/.zsh_history

# Sources
# plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "zap-zsh/nvm"
plug "zsh-users/zsh-syntax-highlighting"

# Keybinds
bindkey '^ ' autosuggest-accept

export PATH="$HOME/.local/bin":$PATH

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme \"Visual Studio Dark+\"" 
    alias catt="bat --theme \"Visual Studio Dark+\"" 
fi
