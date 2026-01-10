#!/bin/bash

###############################################################################
# Dotfiles Installation Script
# Modular cross-platform installer for macOS and Linux
###############################################################################

set -e  # Exit on error

###############################################################################
# Bootstrap: Clone repo if running via curl
###############################################################################

bootstrap_if_needed() {
    # Check if we're in the dotfiles repo (has the scripts directory)
    if [[ ! -d "scripts/install" ]]; then
        echo "📦 Bootstrapping: Cloning dotfiles repository..."
        
        # Clone the repository
        git clone https://github.com/tomijaroli/dotfiles.git "$HOME/dotfiles"
        
        echo "✓ Repository cloned to $HOME/dotfiles"
        echo "🔄 Re-executing installer from cloned repository..."
        echo ""
        
        # Re-execute the script from the cloned repo
        cd "$HOME/dotfiles"
        exec bash "$HOME/dotfiles/install.sh" "$@"
    fi
}

# Run bootstrap check
bootstrap_if_needed "$@"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR="$SCRIPT_DIR"

###############################################################################
# OS Detection
###############################################################################

detect_os() {
    echo "Detecting operating system..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        export OS="macos"
        echo "✓ Detected macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        export OS="linux"
        echo "✓ Detected Linux"
    else
        echo "✗ Unsupported OS: $OSTYPE"
        echo "This installer only supports macOS and Linux"
        exit 1
    fi
}

###############################################################################
# Source installation modules
###############################################################################

source_modules() {
    # Source common utilities
    if [[ -f "$DOTFILES_DIR/scripts/install/common.sh" ]]; then
        source "$DOTFILES_DIR/scripts/install/common.sh"
    else
        echo "✗ Error: common.sh not found at $DOTFILES_DIR/scripts/install/common.sh"
        exit 1
    fi
    
    # Source platform-specific installer
    if [[ -f "$DOTFILES_DIR/scripts/install/${OS}.sh" ]]; then
        source "$DOTFILES_DIR/scripts/install/${OS}.sh"
    else
        echo "✗ Error: ${OS}.sh not found at $DOTFILES_DIR/scripts/install/${OS}.sh"
        exit 1
    fi
}

###############################################################################
# Main installation
###############################################################################

main() {
    clear
    
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║           Dotfiles Installation Script                    ║"
    echo "║           Cross-platform configuration setup              ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Detect OS
    detect_os
    
    # Source modules
    source_modules
    
    # Show installation summary
    echo ""
    echo "Installation Summary:"
    echo "  • OS: $OS"
    echo "  • Dotfiles directory: $DOTFILES_DIR"
    echo "  • Target: $HOME"
    echo ""
    
    # Confirm installation
    read -p "Continue with installation? (y/N) " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    
    # Run platform-specific installation
    if [[ "$OS" == "macos" ]]; then
        run_macos_install
    elif [[ "$OS" == "linux" ]]; then
        run_linux_install
    fi
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║           🎉 Installation Complete! 🎉                     ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
}

# Run main installation
main "$@"
