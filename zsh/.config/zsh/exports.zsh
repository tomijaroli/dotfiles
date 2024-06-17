#!/bin/zsh

# History
export HISTFILE="$XDG_DATA_HOME"/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export EDITOR="nvim"
export TERMINAL="alacritty"
[[ $(uname -m) == "Darwin" ]] && export BROWSER="Safari"
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/bin":$PATH
if [[ $(uname -m) == "Darwin" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init - --path)"
eval "$(rbenv init -)"

if [[ $(uname -m) == "Darwin" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$HOME/scripts"

export GOPATH="$HOME/Developer/go"
export PATH="$PATH:$GOPATH/bin"

eval "$(zoxide init zsh)"
eval "$(gdircolors ~/.dircolors)"
export EXA_COLORS=$LS_COLORS
