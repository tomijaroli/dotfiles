#!/bin/bash

# zsh
alias zrc="nvim ~/.config/zsh/"
alias zl="zsh -l"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# nvim config
alias nvimrc="nvim ~/.config/nvim/"

# TMUX
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias td="tmux detach"
alias tls="tmux ls"
alias tkc="tmux list-panes -a -F '#{pane_tty} #{session_name}' | tmux kill-session -t $1"
alias tka="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias tks="tmux kill-server"

# Git
alias fetch="git fetch -p"
alias co="git checkout"
alias commit="git commit -m"
alias commitall="git commit -am"
alias push="git push origin"
alias rebase="git rebase"
alias gri="git rebase -i"
alias pick="git cherry-pick"
alias grevert="git reset --hard"
alias grmi="git rm -r --cached . && git add ."
function grc() {
    git branch -m $(git rev-parse --abbrev-ref HEAD) $1
}

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
