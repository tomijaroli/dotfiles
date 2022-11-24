#!/bin/bash

echo "Loading aliases"
# zsh
alias zrc="nvim ~/.config/zsh/"
alias zl="zsh -l"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# nvim config
alias nvimrc="nvim ~/.config/nvim/"

# Git
alias grevert="git reset --hard"
function grc() {
    CURRENT_BRANCH=

    git branch -m $(git rev-parse --abbrev-ref HEAD) $1
}

# EXA ls
if [ -x "$(command -v exa)" ]; then
    echo "EXA found"
    alias ls="exa -Slhg --icons --group-directories-first --color=always"
    alias la="exa -Slhga --icons --group-directories-first --color=always"
    alias lt="exa --tree --icons"
fi

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Most memory consuming processes
alias psmem="ps aux | sort -nr -k 4 | head -5"

# Most CPU consuming processes
alias psmem="ps aux | sort -nr -k 3 | head -5"

