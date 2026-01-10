#!/bin/zsh

# Linux-specific aliases

# TMUX (Linux-specific kill all sessions)
alias tka="tmux ls | grep : | cut -d. -f1 | awk '{print substr(\$1, 0, length(\$1)-1)}' | xargs kill"

# Search on google (Linux - using xdg-open)
function google() {
    xdg-open "http://www.google.com/search?q=$1";
}
