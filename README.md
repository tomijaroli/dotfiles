# Dotfiles

This is a simple and minimalistic dotfile setup inspired by [Chris@Machine](https://github.com/ChristianChiarulli/Machfiles)'s setup.

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

#### GNU Stow

```
brew install stow && brew doctor
```

#### EXA (optional)

```
brew install exa && brew doctor
```

#### Zap - ZSH plugin manager

```
sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
```

### Install dotfiles configs with stow

```
cd ~/dotfiles && stow */
```
