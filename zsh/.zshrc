#!/bin/zsh

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    OS_TYPE="unknown"
fi

# Options
stty stop undef
unsetopt BEEP

# Load Zap plugin manager
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Plugins
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"

# Sources - Common exports
plug "$HOME/.config/zsh/exports.common.zsh"

# Platform-specific exports
if [[ "$OS_TYPE" == "macos" ]]; then
    plug "$HOME/.config/zsh/exports.macos.zsh"
elif [[ "$OS_TYPE" == "linux" ]]; then
    plug "$HOME/.config/zsh/exports.linux.zsh"
fi

# Common aliases
plug "$HOME/.config/zsh/aliases.common.zsh"

# Platform-specific aliases
if [[ "$OS_TYPE" == "macos" ]]; then
    plug "$HOME/.config/zsh/aliases.macos.zsh"
elif [[ "$OS_TYPE" == "linux" ]]; then
    plug "$HOME/.config/zsh/aliases.linux.zsh"
fi

# Secrets (make sure to never track your secret file)
[ -f $HOME/.config/zsh/.secrets.zsh ] && plug "$HOME/.config/zsh/.secrets.zsh"

# Platform-specific plugins
if [[ "$OS_TYPE" == "macos" ]]; then
    # Dock plugin (macOS only)
    [ -f "$HOME/dotfiles/scripts/dock/zsh/dock.plugin.zsh" ] && plug "$HOME/dotfiles/scripts/dock/zsh/dock.plugin.zsh"
fi

# Additional sourcing
[ -f $HOME/.pymobiledevice3.zsh ] && source "$HOME/.pymobiledevice3.zsh"

# Keybinds
bindkey -e
bindkey '^ ' autosuggest-accept

export PATH="$HOME/.local/bin":$PATH

# Colored cat (bat)
if command -v bat &>/dev/null; then
    alias cat="bat -pp --theme \"Visual Studio Dark+\""
    alias catt="bat --theme \"Visual Studio Dark+\""
fi

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# <-- Start of core-developer-tools -->
source "/Users/tamas.jaroli/Developer/core-developer-tools/setup/shell/aliases.sh"
# <-- End of core-developer-tools -->
