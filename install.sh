#!/bin/bash

# Install Xcode Commandline tools
if [[ $(xcode-select -p 1>/dev/null) != 0 ]]; then
    XCODE_MESSAGE="$(osascript -e 'tell app "System Events" to display dialog "Please click install when Command Line Developer Tools appears"')"
    if [ "$XCODE_MESSAGE" = "button returned:OK" ]; then
        xcode-select --install
    else
        echo "You have cancelled the installation, please rerun the installer."
        # you have forgotten to exit here
        exit
    fi
fi

until [[ $(xcode-select -p 1>/dev/null) != 0 ]]
    echo -n "."
    sleep 5
done
echo
echo "Xcode Commandline tools installed."
# xcode-select -p 1>/dev/null
# if [[ $? != 0 ]] ; then
#     echo "Installing Xcode Commandline tools..."
#     xcode-select --install &> /dev/null
#
#     # Wait until XCode Command Line Tools installation has finished.
#     until $(xcode-select --print-path &> /dev/null); do
#         sleep 5;
#     done
#     echo "Xcode Commandline tools installed."
# fi

# Clone dotfiles repository
echo "Cloning dotfiles repository..."
git clone https://github.com/tomijaroli/dotfiles.git ~/dotfiles

# Install or update Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Homebrew installation not found, installing..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # Update brew formulae
    echo "Homebrew installation found, updating..."
    brew update
fi

# Install packages via homebrew 
echo "Installing packages via Homebrew..."
brew doctor
brew install magic-wormhole nvm pyenv rbenv ruby-build swiftlint xcodegen
brew install --cask alacritty amethyst appcleaner discord fork google-chrome insomnia meetingbar proxyman
# Future improvement: use Brewfile for installation
# https://github.com/Homebrew/homebrew-bundle

# Install nix package manager
which -s nix-env
if [[ $? != 0 ]] ; then
    echo "Installing nix package manager..."
    sh <(curl -L https://nixos.org/nix/install)
fi

# TODO: Need to find a proper solution to source the nix mid-script so I don't have to reload the shell.
# Reload shell to register nix env
# echo "Reloading shell..."
# zsh -l

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
sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)

# Install TPM - TMUX Package manager
echo "Installing TPM - TMUX Package manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install dotfiles config with stow
echo "Installing dotfiles configuration..."
cd ~/dotfiles && stow */

echo "All done!"
