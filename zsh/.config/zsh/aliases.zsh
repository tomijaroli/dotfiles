#!/bin/bash

# zsh
alias dotrc="nvim ~/dotfiles"
alias zl=". ~/.zshrc"
alias zapu="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias jd="z ~/dotfiles"

# nvim config
alias vim="nvim"
alias vimrc="vim ~/.config/nvim/"
alias jv="z ~/.config/nvim"

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
alias tka="tmux ls | cut -d: -f1 | xargs -n 1 tmux kill-session -t"
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
alias lg="lazygit"

# iOS development
alias xkill="killall Xcode"
function xopen() {
    project_file=$(find . -type d -maxdepth 1 -name '*.xcodeproj')
    if [ -z "$project_file" ]
    then
        echo "Project file not found in the current directory!"
    else
        open ${project_file}
    fi
}
alias xrl="xed .; osascript -e 'tell app "XCode" to close window 0'; xed ."

alias deeplink="xcrun simctl openurl booted"

# Listing

# EZA ls
if [ -x "$(command -v eza)" ]; then
    alias ls="eza --icons --group-directories-first --color=always"
    alias ll="eza -Slhg --icons --group-directories-first --color=always"
    alias lla="eza -Slhga --icons --group-directories-first --color=always"
    alias la="eza -Shga --icons --group-directories-first --color=always"
    alias tree="eza --tree --icons"
else
    alias ls="ls --color=auto -F"
    alias ll="ls --color=auto -F -l"
    alias lla="ls --color=auto -F -la"
    alias la="ls --color=auto -F -a"
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

