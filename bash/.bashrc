#!/bin/bash

# Options
set -o vi
set bell-style none
stty stop undef

# Auto completion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

source "$HOME/.config/bash/exports.bash"
source "$HOME/.config/bash/prompt.bash"
source "$HOME/.config/bash/aliases.bash"
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

# Zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

