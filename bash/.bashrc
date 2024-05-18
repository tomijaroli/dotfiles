# source "$HOME/.config/zsh/prompt.zsh"

# autoload -Uz vcs_info
# autoload -U colors && colors
#
# zstyle ':vcs_info:*' enable git
#
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
#
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
# +vi-git-untracked(){
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#         git status --porcelain | grep '??' &> /dev/null ; then
#         hook_com[staged]+='!'
#     fi
# }
#
# zstyle ':vcs_info:*' check_for_changes true
#
# zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[blue]%} %b%{$fg[blue]%})"

set -o vi

reset=$(tput sgr0)
bold=$(tput bold)
red=$(tput setaf 9)
green=$(tput setaf 10)
blue=$(tput setaf 12)
cyan=$(tput setaf 14)
white=$(tput setaf 15)

source "$HOME/.config/bash/git-prompt.sh"
export PS1="\[$reset\]\[$bold\]\[$blue\][\[$white\]\u\[$red\]@\[$white\]\h\[$blue\]] \[$green\]➜ \[$cyan\]\W\[$blue\]$(__git_ps1)\[$reset\] $ "
