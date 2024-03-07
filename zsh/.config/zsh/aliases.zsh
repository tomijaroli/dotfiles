#!/bin/bash

# zsh
alias dotrc="nvim ~/dotfiles"
alias zl=". ~/.zshrc"
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# nvim config
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/"

# yabai + skhd
alias startwm="yabai --start-service && skhd --start-service"
alias restartwm="yabai --restart-service && skhd --restart-service"
alias stopwm="yabai --stop-service && skhd --stop-service"

# TMUX
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias td="tmux detach"
alias tls="tmux ls"
alias tkc="tmux kill-session"
alias tka="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias tks="tmux kill-server"

# Navigation
alias j="z"
alias f="zi"

# Git
alias gf="git fetch -p"
alias co="git checkout"
alias gc="git commit -m"
alias gca="git commit -am"
alias gp="git push origin"
alias gr="git rebase"
alias gri="git rebase -i"
alias gpick="git cherry-pick"
alias grevert="git reset --hard"
alias grevertlast="git reset --soft HEAD~1"
alias grmignored="git rm -r --cached . && git add ."
function grc() {
    git branch -m $(git rev-parse --abbrev-ref HEAD) $1
}
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias prunemerged="git branch --merged | egrep -v '(^\*|master|production|develop)' >/tmp/merged-branches && nvim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"
function moveonto() {
    git rebase -i HEAD~$1 --onto $2
}

# Listing
alias ls="ls --color=auto -F"
alias ll="ls --color=auto -F -l"
alias lla="ls --color=auto -F -la"
alias la="ls --color=auto -F -a"

# EXA ls
if [ -x "$(command -v exa)" ]; then
    alias ls="exa --icons --group-directories-first --color=always"
    alias ll="exa -Slhg --icons --group-directories-first --color=always"
    alias lla="exa -Slhga --icons --group-directories-first --color=always"
    alias la="exa -Shga --icons --group-directories-first --color=always"
    alias tree="exa --tree --icons"
fi

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Most memory consuming processes
alias psmem="ps aux | sort -nr -k 4 | head -5"

# Most CPU consuming processes
alias pscpu="ps aux | sort -nr -k 3 | head -5"

# Search on google
function google() {
    open -a "Safari" "http://www.google.com/search?q= $1";
}

# Find aliases
alias findalias="PS4='+%x:%I>' zsh -i -x -c '' |& grep "

