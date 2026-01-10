#!/bin/bash

# Linux-specific installation script

###############################################################################
# Linux distribution detection
###############################################################################

detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        DISTRO=$ID
        DISTRO_FAMILY=$ID_LIKE
    elif command_exists lsb_release; then
        DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
    else
        DISTRO="unknown"
    fi
    
    log_info "Detected distribution: $DISTRO"
}

###############################################################################
# Package installation
###############################################################################

# Install packages based on distribution
install_linux_packages() {
    log_section "Installing Linux Packages"
    
    detect_distro
    
    # Required packages
    local packages="stow git alacritty tmux zsh neovim nvm bat eza zoxide fzf starship"
    local wayland_packages="hyprland waybar rofi mako foot wlogout swaylock"
    
    case "$DISTRO" in
        arch|manjaro|endeavouros)
            log_info "Installing packages via yay..."
            yay -S --needed --noconfirm $packages $wayland_packages
            log_success "Packages installed via yay"
            ;;
            
        ubuntu|debian|pop|linuxmint)
            log_info "Installing packages via apt..."
            sudo apt update
            sudo apt install -y stow git alacritty tmux zsh neovim build-essential curl
            log_warning "Some packages may need to be installed from alternative sources"
            log_info "Consider installing: bat (batcat), eza, zoxide, fzf, starship"
            ;;
            
        fedora|rhel|centos)
            log_info "Installing packages via dnf..."
            sudo dnf install -y stow git alacritty tmux zsh neovim bat eza zoxide fzf starship
            log_warning "Wayland packages may need to be installed from COPR or compiled"
            ;;
            
        *)
            log_warning "Unknown distribution: $DISTRO"
            log_warning "Please install these packages manually:"
            echo "  Required: $packages"
            echo "  Wayland:  $wayland_packages"
            read -p "Press Enter to continue..."
            ;;
    esac
}

# Install AUR helper (Arch-based only)
install_aur_helper() {
    if [[ "$DISTRO" == "arch" || "$DISTRO" == "manjaro" || "$DISTRO" == "endeavouros" ]]; then
        if ! command_exists yay; then
            log_info "Installing yay (AUR helper)..."
            
            # Install base-devel if not already installed
            sudo pacman -S --needed --noconfirm base-devel git
            
            # Clone and build yay
            cd /tmp
            git clone https://aur.archlinux.org/yay.git
            cd yay
            makepkg -si --noconfirm
            cd "$DOTFILES_DIR"
            
            log_success "yay installed"
        else
            log_success "yay already installed"
        fi
    fi
}

###############################################################################
# Linux-specific configurations
###############################################################################

# Stow Linux-specific packages
stow_linux_packages() {
    log_section "Installing Linux-Specific Dotfiles"
    
    cd "$DOTFILES_DIR" || exit 1
    local stow_cmd="stow"
    
    for package in "${LINUX_STOW_PACKAGES[@]}"; do
        if [[ -d "$package" ]]; then
            log_info "Stowing $package..."
            $stow_cmd "$package" 2>/dev/null && log_success "$package stowed" || log_warning "Failed to stow $package (may already be linked)"
        else
            log_warning "Package $package not found, skipping"
        fi
    done
}

# Setup Wayland/Hyprland
setup_hyprland() {
    log_section "Configuring Hyprland"
    
    # Check if Hyprland is installed
    if command_exists Hyprland; then
        log_success "Hyprland is installed"
        
        # Ensure Hyprland will start on login (optional)
        log_info "To start Hyprland on login, add to your shell profile:"
        log_info "  if [ -z \"\$DISPLAY\" ] && [ \"\$XDG_VTNR\" = 1 ]; then"
        log_info "    exec Hyprland"
        log_info "  fi"
    else
        log_warning "Hyprland not installed. Install it via your package manager."
    fi
}

# Install NVM (Linux-specific)
install_nvm_linux() {
    log_section "Installing NVM"
    
    if [[ ! -d "$HOME/.nvm" ]]; then
        log_info "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        log_success "NVM installed"
    else
        log_info "NVM already installed"
    fi
}

###############################################################################
# Main Linux installation function
###############################################################################

run_linux_install() {
    log_section "Linux Installation Starting"
    
    # Detect distribution
    detect_distro
    
    # Linux-specific installations
    install_aur_helper
    install_linux_packages
    install_nvm_linux
    
    # Common installations
    install_zap
    install_tpm
    backup_shell_configs
    
    # Stow packages
    stow_common_packages "stow"
    stow_linux_packages
    
    # Platform-specific configurations
    setup_alacritty_config "linux"
    setup_hyprland
    
    # Additional installations
    install_fonts
    install_node
    
    log_section "Linux Installation Complete!"
    log_success "All done! Please restart your terminal or re-login."
    log_info "Don't forget to:"
    log_info "  - Install TMUX plugins: Open tmux and press prefix + I"
    log_info "  - Review your shell configs in ~/.zshrc and ~/.bashrc"
    log_info "  - If using Hyprland, logout and select it from your display manager"
}
