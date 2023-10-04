# Portable environment

A simple and minimal environment setup with dotfiles and easy installation, using:

- [Alacritty terminal emulator](https://github.com/alacritty/alacritty)
- [ZSH](https://www.zsh.org/) shell
- [Amethyst](https://ianyh.com/amethyst/) window manager and [tmux](https://github.com/tmux/tmux)
- [GNU Stow](https://www.gnu.org/software/stow/) for linking config files

The goal of the project was to create a one command installer, so every time I have a clean install of macOS, I can setup my usual environment with the least friction possbile, and save time with automating all the tedious manual configuration.

Also I aimed to keep the setup as lightweight as possible (e.g. no oh-my-zsh used).

## Preview

![Screenshot 2023-01-06 at 16 00 20](https://user-images.githubusercontent.com/3617451/211028707-faf600a3-d404-4e43-b6e8-c00a59fbbe95.jpg)

## Installation

```
sh <(curl -sL https://raw.githubusercontent.com/tomijaroli/dotfiles/main/install.sh)
```

### What does install do

- Xcode Command Line Tools installation
- [Homebrew](https://brew.sh/) installation, with the packages and casks needed
- Plugin manager installation for TMUX ([TPM](https://github.com/tmux-plugins/tpm)) and for ZSH ([Zap](https://github.com/zap-zsh/zap) - minimal plugin manager)
- Installs and links all my configuration files from the `dotfiles` folder
- Installs my [neovim](https://neovim.io/) config
- Installs latest [nodejs](https://nodejs.org/en/) (so [tree-sitter](https://github.com/tree-sitter/tree-sitter) can be happy)
- Installs some patched fonts that can be used in the terminal and in neovim

### Neovim config

My neovim configuration lives in another repository, [can be found here](https://github.com/tomijaroli/nvim-config)

## Tools and packages installed automatically

### via Homebrew

```
bat coreutils exa fzf git git-lfs magic-wormhole neovim nmap nvm poetry pyenv ripgrep rbenv ruby-build stow swiftlint tldr tmux tree tree-sitter xcodegen yarn zoxide zsh
```

### via Homebrew casks

```
alacritty amethyst appcleaner discord fork google-chrome insomnia meetingbar proxyman
```
