#!/bin/bash

# macOS-specific installation script

###############################################################################
# macOS specific functions
###############################################################################

# Install Xcode Command Line Tools
install_xcode_cli() {
    log_section "Checking Xcode Command Line Tools"
    
    xcode-select -p &> /dev/null
    if [[ $? -ne 0 ]]; then
        log_info "Xcode Command Line Tools not found. Installing from Software Update..."
        
        touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
        PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
        softwareupdate -i "$PROD" --verbose
        
        log_success "Xcode Command Line Tools installed"
    else
        log_success "Xcode Command Line Tools already installed"
    fi
}

# Install or update Homebrew
install_homebrew() {
    log_section "Setting Up Homebrew"
    
    if ! command_exists brew; then
        log_info "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        log_success "Homebrew installed"
    else
        log_success "Homebrew already installed"
        log_info "Updating Homebrew..."
        brew update
    fi
}

# Install packages via Homebrew
install_brew_packages() {
    log_section "Installing Homebrew Packages"
    
    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        log_info "Running brew doctor..."
        /opt/homebrew/bin/brew doctor
        
        log_info "Installing packages from Brewfile..."
        /opt/homebrew/bin/brew bundle install --file="$DOTFILES_DIR/Brewfile"
        log_success "Homebrew packages installed"
    else
        log_warning "Brewfile not found, skipping package installation"
    fi
}

# Disable font smoothing for terminals
configure_terminal_fonts() {
    log_section "Configuring Terminal Font Rendering"
    
    log_info "Disabling font smoothing for Alacritty..."
    defaults write org.alacritty AppleFontSmoothing -int 0
    
    log_success "Terminal font rendering configured"
}

# Stow macOS-specific packages
stow_macos_packages() {
    log_section "Installing macOS-Specific Dotfiles"
    
    cd "$DOTFILES_DIR" || exit 1
    local stow_cmd="/opt/homebrew/bin/stow"
    
    for package in "${MACOS_STOW_PACKAGES[@]}"; do
        if [[ -d "$package" ]]; then
            log_info "Stowing $package..."
            $stow_cmd "$package" 2>/dev/null && log_success "$package stowed" || log_warning "Failed to stow $package (may already be linked)"
        else
            log_warning "Package $package not found, skipping"
        fi
    done
}

# Install dock configuration
install_dock_config() {
    log_section "Installing Dock Configuration"
    
    if [[ -f "$DOTFILES_DIR/scripts/dock/install-dock.sh" ]]; then
        bash "$DOTFILES_DIR/scripts/dock/install-dock.sh"
        log_success "Dock configuration installed"
    else
        log_warning "Dock installer not found, skipping"
    fi
}

###############################################################################
# Main macOS installation function
###############################################################################

run_macos_install() {
    log_section "macOS Installation Starting"
    
    # macOS-specific installations
    install_xcode_cli
    install_homebrew
    install_brew_packages
    configure_terminal_fonts
    
    # Common installations
    install_zap
    install_tpm
    backup_shell_configs
    
    # Stow packages
    stow_common_packages "/opt/homebrew/bin/stow"
    stow_macos_packages
    
    # Platform-specific configurations
    setup_alacritty_config "macos"
    
    # Additional installations
    install_fonts
    install_node
    install_dock_config
    
    log_section "macOS Installation Complete!"
    log_success "All done! Please restart your terminal."
    log_info "Don't forget to:"
    log_info "  - Install TMUX plugins: Open tmux and press prefix + I"
    log_info "  - Review your shell configs in ~/.zshrc and ~/.bashrc"
}
