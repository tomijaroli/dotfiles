#!/bin/bash

# zsh
alias zrc="nvim ~/.config/zsh/"
alias zl="zsh -l"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# nvim config
alias nvimrc="nvim ~/.config/nvim/"

# Git
alias grevert="git reset --hard"
function grc() {
    git branch -m $(git rev-parse --abbrev-ref HEAD) $1
}
alias grmi="git rm -r --cached . && git add ."

# EXA ls
if [ -x "$(command -v exa)" ]; then
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

# Search on google
function google() {
    open -a "Safari" "http://www.google.com/search?q= $1";
}
