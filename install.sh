#!/bin/bash

xcode-select -p &> /dev/null
if [[ $? -ne 0 ]]; then
    echo "Xcode Command Line Tools for Xcode not found. Installing from Software Update..."

    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose;
fi

# Clone dotfiles repository
echo "Cloning dotfiles repository..."
git clone https://github.com/tomijaroli/dotfiles.git ~/dotfiles

# Install or update Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew installation not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Update brew formulae
    echo "Homebrew installation found, updating..."
    brew update
fi

# Install packages via homebrew 
echo "Installing packages via Homebrew..."
/opt/homebrew/bin/brew doctor
/opt/homebrew/bin/brew install magic-wormhole nvm pyenv rbenv ruby-build swiftlint xcodegen
/opt/homebrew/bin/brew install --cask alacritty amethyst appcleaner discord fork google-chrome insomnia meetingbar proxyman
# Future improvement: use Brewfile for installation
# https://github.com/Homebrew/homebrew-bundle

# Install nix package manager
which -s nix-env
if [[ $? != 0 ]] ; then
    echo "Installing nix package manager..."
    /bin/bash -c "$(curl -L https://nixos.org/nix/install)"
fi

# Reload shell to register nix env
echo "Reloading nix environment"
export PATH="$PATH:/nix/var/nix/profiles/default/bin"
[ -f ~/.nix.profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh
[ -f ~/.zshrc ] && source ~/.zshrc

# Install packages via nix
echo "Installing packages via nix package manager..."
nixpkgs=(bat fzf git git-lfs neovim nmap poetry ripgrep stow tldr tmux tree yarn zoxide)
for package in ${nixpkgs[@]}; do
    echo "Installing $package..."
    nix-env -iA nixpkgs.$package
done

# Install custom nix derivatives
echo "Installing custom nix derivatives..."
nix-env -i -f ~/dotfiles/*.nix

# Install zap zsh plugin manager
echo "Installing zap plugin manager for zsh..."
/bin/bash -c "$(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)"

# Install TPM - TMUX Package manager
echo "Installing TPM - TMUX Package manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install dotfiles config with stow
echo "Installing dotfiles configuration..."
cd ~/dotfiles && stow */

echo "Installing neovim config..."
git clone https://github.com/tomijaroli/nvim-config.git ~/.config/nvim

echo "All done!"
