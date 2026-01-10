#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "Detected macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "Detected Linux"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# macOS specific: Install Xcode Command Line Tools
if [[ "$OS" == "macos" ]]; then
    xcode-select -p &> /dev/null
    if [[ $? -ne 0 ]]; then
        echo "Xcode Command Line Tools for Xcode not found. Installing from Software Update..."

        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        softwareupdate -i "$PROD" --verbose;
    fi
fi

# Clone dotfiles repository
echo "Cloning dotfiles repository..."
git clone https://github.com/tomijaroli/dotfiles.git ~/dotfiles

# Install or update Homebrew (macOS only)
if [[ "$OS" == "macos" ]]; then
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
    /opt/homebrew/bin/brew bundle install --file=~/dotfiles/Brewfile

    echo "Disable font smoothing for terminals..."
    defaults write org.alacritty AppleFontSmoothing -int 0
    defaults write net.kovidgoyal.kitty AppleFontSmoothing -int 0
else
    # Linux package installation
    echo "On Linux, please install packages manually or use your distribution's package manager"
    echo "Required packages: stow, git, alacritty, kitty, tmux, zsh, neovim, nvm"
fi

# Install zap zsh plugin manager
echo "Installing zap plugin manager for zsh..."
/bin/bash -c "$(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)"

# Install TPM - TMUX Package manager
echo "Installing TPM - TMUX Package manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install dotfiles config with stow
echo "Installing dotfiles configuration..."
if [[ -f ~/.zshrc ]]; then
    echo "Existing ~/.zshrc file found, created backup at ~/.zshrc.bak"
    mv ~/.zshrc ~/.zshrc.bak
fi

if [[ -f ~/.zprofile ]]; then
    echo "Existing ~/.zprofile file found, created backup at ~/.zprofile.bak"
    mv ~/.zprofile ~/.zprofile.bak
fi

# Determine stow command based on OS
if [[ "$OS" == "macos" ]]; then
    STOW_CMD="/opt/homebrew/bin/stow"
else
    STOW_CMD="stow"
fi

cd ~/dotfiles && $STOW_CMD alacritty dircolors git kitty lldb skhd tmux yabai zsh

# Platform-specific Alacritty configuration
echo "Setting up platform-specific Alacritty configuration..."
if [[ "$OS" == "macos" ]]; then
    ln -sf ~/.config/alacritty/alacritty.macos.toml ~/.config/alacritty/alacritty.toml
    echo "✓ Linked macOS Alacritty config"
else
    ln -sf ~/.config/alacritty/alacritty.linux.toml ~/.config/alacritty/alacritty.toml
    echo "✓ Linked Linux Alacritty config"
fi

echo "Installing neovim config..."
git clone https://github.com/tomijaroli/nvim-config.git ~/.config/nvim

echo "Installing node..."
export NVM_DIR="$HOME/.nvm"
if [[ "$OS" == "macos" ]]; then
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi
nvm install node
nvm use stable

echo "Installing patched fonts..."
fonts/install.sh

# macOS specific: Dock configuration
if [[ "$OS" == "macos" ]]; then
    if [[ -f "$HOME/dotfiles/scripts/dock/install-dock.sh" ]]; then
      bash "$HOME/dotfiles/scripts/dock/install-dock.sh"
    else
      echo "⚠️ Dock installer missing, skipping"
    fi
fi

echo "All done!"
