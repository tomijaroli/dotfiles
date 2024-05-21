#!/bin/bash

source "$HOME/.config/bash/git-prompt.sh"

reset=$(tput sgr0)
bold=$(tput bold)
red=$(tput setaf 9)
green=$(tput setaf 10)
yellow=$(tput setaf 11)
blue=$(tput setaf 12)
cyan=$(tput setaf 14)
white=$(tput setaf 15)

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1

__color_prompt_with_git_info() {
	local pre_git_ps1 post_git_ps1

	pre_git_ps1="\[$reset\]\[$bold\]\[$blue\][\[$white\]\u\[$red\]@\[$white\]\h\[$blue\]] \[$green\]➜ \[$cyan\]\W\[$reset\] "
	post_git_ps1="\[$white\]$ \[$reset\]"

	__git_ps1 "$pre_git_ps1" "$post_git_ps1" "\[$blue\](\[$blue\]%s\[$blue\]) "
}

PROMPT_COMMAND=__color_prompt_with_git_info
