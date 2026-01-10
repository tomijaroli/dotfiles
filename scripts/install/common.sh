#!/bin/bash

# Common utilities and functions for dotfiles installation

###############################################################################
# Colors and logging
###############################################################################

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_section() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

###############################################################################
# Common package lists
###############################################################################

# Packages to stow on all platforms
COMMON_STOW_PACKAGES=(
    alacritty
    bash
    dircolors
    git
    nvim
    starship
    tmux
    vim
    zsh
)

# macOS-only packages
MACOS_STOW_PACKAGES=(
    dock
    lldb
)

# Linux-only packages
LINUX_STOW_PACKAGES=(
    electron
    fastfetch
    foot
    greetd
    hypr
    mako
    rofi
    swaylock
    themes
    wallpapers
    waybar
    wlogout
)

###############################################################################
# Utility functions
###############################################################################

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Backup existing file
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        log_warning "Existing $file found, creating backup at ${file}.bak"
        mv "$file" "${file}.bak"
    fi
}

# Check if running from the dotfiles directory
ensure_dotfiles_dir() {
    if [[ ! -f "$DOTFILES_DIR/install.sh" ]]; then
        log_error "Must be run from the dotfiles directory"
        exit 1
    fi
}

# Clone dotfiles repository (for fresh installs)
clone_dotfiles() {
    if [[ ! -d "$HOME/dotfiles" ]]; then
        log_info "Cloning dotfiles repository..."
        git clone https://github.com/tomijaroli/dotfiles.git "$HOME/dotfiles"
    else
        log_info "Dotfiles directory already exists"
    fi
}

###############################################################################
# Common installation tasks
###############################################################################

# Install zap (zsh plugin manager)
install_zap() {
    if [[ ! -d "$HOME/.local/share/zap" ]]; then
        log_info "Installing zap plugin manager for zsh..."
        /bin/bash -c "$(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)"
        log_success "Zap installed"
    else
        log_info "Zap already installed"
    fi
}

# Install TPM (tmux plugin manager)
install_tpm() {
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Installing TPM - TMUX Package manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        log_success "TPM installed"
    else
        log_info "TPM already installed"
    fi
}

# Backup shell config files
backup_shell_configs() {
    log_info "Backing up existing shell configuration files..."
    backup_file "$HOME/.zshrc"
    backup_file "$HOME/.zprofile"
    backup_file "$HOME/.bashrc"
    backup_file "$HOME/.bash_profile"
}

# Stow common packages
stow_common_packages() {
    log_section "Installing Common Dotfiles"
    
    local stow_cmd="$1"
    cd "$DOTFILES_DIR" || exit 1
    
    for package in "${COMMON_STOW_PACKAGES[@]}"; do
        if [[ -d "$package" ]]; then
            log_info "Stowing $package..."
            $stow_cmd "$package" 2>/dev/null && log_success "$package stowed" || log_warning "Failed to stow $package (may already be linked)"
        else
            log_warning "Package $package not found, skipping"
        fi
    done
}

# Setup platform-specific Alacritty config
setup_alacritty_config() {
    local platform="$1"
    log_info "Setting up platform-specific Alacritty configuration..."
    
    if [[ "$platform" == "macos" ]]; then
        ln -sf ~/.config/alacritty/alacritty.macos.toml ~/.config/alacritty/alacritty.toml
        log_success "Linked macOS Alacritty config"
    else
        ln -sf ~/.config/alacritty/alacritty.linux.toml ~/.config/alacritty/alacritty.toml
        log_success "Linked Linux Alacritty config"
    fi
}

# Install fonts
install_fonts() {
    log_section "Installing Fonts"
    
    if [[ -f "$DOTFILES_DIR/fonts/install.sh" ]]; then
        bash "$DOTFILES_DIR/fonts/install.sh"
    else
        log_warning "Font installation script not found"
    fi
}

# Install NVM and Node
install_node() {
    log_section "Installing Node.js via NVM"
    
    export NVM_DIR="$HOME/.nvm"
    
    # Source NVM based on platform
    if [[ "$OS" == "macos" ]]; then
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    else
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    fi
    
    if command_exists nvm; then
        log_info "Installing latest Node.js..."
        nvm install node
        nvm use stable
        log_success "Node.js installed"
    else
        log_warning "NVM not found, skipping Node.js installation"
    fi
}
