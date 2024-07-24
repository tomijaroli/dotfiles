if [ -f ~/.zshrc ]; then
    . ~/.zshrc
fi

# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

[[ $(uname -m) == "Darwin" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
