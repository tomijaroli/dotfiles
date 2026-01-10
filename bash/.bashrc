#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS_TYPE="linux"
else
    OS_TYPE="unknown"
fi

# Options
set -o vi
set bell-style none
stty stop undef

# Auto completion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Source common exports
source "$HOME/.config/bash/exports.common.bash"

# Source platform-specific exports
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$HOME/.config/bash/exports.macos.bash"
elif [[ "$OS_TYPE" == "linux" ]]; then
    source "$HOME/.config/bash/exports.linux.bash"
fi

# Source prompt
source "$HOME/.config/bash/prompt.bash"

# Source common aliases
source "$HOME/.config/bash/aliases.common.bash"

# Source platform-specific aliases
if [[ "$OS_TYPE" == "macos" ]]; then
    source "$HOME/.config/bash/aliases.macos.bash"
elif [[ "$OS_TYPE" == "linux" ]]; then
    source "$HOME/.config/bash/aliases.linux.bash"
fi

# Source secrets if exists
[ -f $HOME/.config/bash/.secrets.bash ] && source "$HOME/.config/bash/.secrets.bash"

export PATH="$HOME/.local/bin:$PATH"

# Colored cat (bat)
if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme \"visual studio dark+\"" 
    alias catt="bat --theme \"visual studio dark+\"" 
fi

# Bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Starship prompt (if available)
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi
