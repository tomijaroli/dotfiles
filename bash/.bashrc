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

source "$HOME/.config/bash/prompt.bash"
source "$HOME/.config/bash/exports.bash"
source "$HOME/.config/bash/aliases.bash"
