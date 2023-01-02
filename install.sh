#!/bin/bash

# Install Xcode Commandline tools
xcode-select -p 1>/dev/null
if [[ $? != 0 ]] ; then
    xcode-select --install
fi

# Clone dotfiles repository
git clone https://github.com/tomijaroli/dotfiles.git dotfiles-demo

# Install or update Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # Update brew formulae and packages
    brew update
    brew upgrade
fi

# Install packages via homebrew 
brew doctor
brew install magic-wormhole nvm
brew install --cask alacritty amethyst appcleaner fork insomnia meetingbar proxyman
# Future improvement: use Brewfile for installation
# https://github.com/Homebrew/homebrew-bundle

# Install nix package manager
which -s nix-env
if [[ $? != 0 ]] ; then
    sh <(curl -L https://nixos.org/nix/install)
fi

# Install packages via nix
nixpkgs = (stow bat fzf git git-lfs neovim poetry ripgrep stow tldr tmux tree yarn zoxide)
for package in ${ nixpkgs[@] }; do
    nix-env -iA nixpkgs.$package
done

# Install custom nix derivatives
nix-env -i -f ~/dotfiles/*.nix

# Install zap zsh plugin manager
sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)

# Install TPM - TMUX Package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install dotfiles config with stow
cd ~/dotfiles && stow */
