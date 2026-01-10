#!/bin/zsh

# macOS-specific aliases

# Window management - yabai + skhd (macOS only)
alias startwm="yabai --start-service && skhd --start-service"
alias restartwm="yabai --restart-service && skhd --restart-service"
alias stopwm="yabai --stop-service && skhd --stop-service"

# TMUX (macOS-specific kill all sessions)
alias tka="tmux ls | cut -d: -f1 | xargs -n 1 tmux kill-session -t"

# iOS development (macOS only)
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
alias xrl="xed .; osascript -e 'tell app \"XCode\" to close window 0'; xed ."
alias deeplink="xcrun simctl openurl booted"

# Search on google (macOS - using open command)
function google() {
    open -a "Safari" "http://www.google.com/search?q= $1";
}
