

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
/opt/homebrew/bin/brew install bat coreutils exa fzf git git-lfs magic-wormhole neovim nmap nvm poetry pyenv ripgrep rbenv ruby-build stow swiftlint tldr tmux tree tree-sitter xcodegen yarn zoxide zsh
/opt/homebrew/bin/brew install --cask alacritty amethyst appcleaner discord dozer firefox fork google-chrome insomnia kitty meetingbar obsidian proxyman
# Future improvement: use Brewfile for installation
# https://github.com/Homebrew/homebrew-bundle

echo "Disable font smoothing for terminals..."
defaults write org.alacritty AppleFontSmoothing -int 0
defaults write net.kovidgoyal.kitty AppleFontSmoothing -int 0

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

cd ~/dotfiles && /opt/homebrew/bin/stow alacritty dircolors kitty lldb tmux zsh

echo "Installing neovim config..."
git clone https://github.com/tomijaroli/nvim-config.git ~/.config/nvim

echo "Installing node..."
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
nvm install node
nvm use stable

echo "Installing patched fonts..."
fonts/install.sh

echo "All done!"
