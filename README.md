# Dotfiles

This is a simple and minimalistic dotfile setup inspired by [Chris@Machine](https://github.com/ChristianChiarulli/Machfiles)'s setup.

## Preview

![Screenshot 2022-11-26 at 17 59 23](https://user-images.githubusercontent.com/3617451/204097683-cd667925-a3f5-4dda-a18b-6aaa4f1477c6.jpg)

## Known issues

When using `stow */` in the stow folder, it does not take ignore file into account and it also symlinks the git folder's content into the user directory.

## Installation

### Clone this repository to your home folder

```
git clone git@github.com:tomijaroli/dotfiles.git ~/dotfiles
```

### Dependencies

#### Install Xcode CLI tools

```
xcode-select --install
```

#### Homebrew

```
/usr/bin/ruby -e "$(curl -fsSL (https://raw.githubusercontent.com/Homebrew/install/master/install))"
```

#### Install cli apps via Homebrew

```
brew install stow exa tmux
```

#### Intstall native apps via Homebrew

```
brew install --cask alacritty
```

#### Zap - ZSH plugin manager

```
sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
```

#### TPM - TMUX Package manager

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Install dotfiles configs with stow

```
cd ~/dotfiles && stow */
```
