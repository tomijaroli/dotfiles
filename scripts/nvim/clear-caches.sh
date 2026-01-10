#!/usr/bin/env bash

# Helper functions for colored messages
info() { echo -e "\033[1;34m$1\033[0m"; }
warn() { echo -e "\033[1;33m$1\033[0m"; }
error() { echo -e "\033[1;31m$1\033[0m"; }

# Function to handle Neovim config cleanup
clear_config() {
    info "What do you want to do with your Neovim config?"
    echo "  1) Delete (~/.config/nvim)"
    echo "  2) Backup to ~/.config/nvim.bak"
    echo "  3) Skip"
    read -rp "Choose an option (1-3): " choice

    case "$choice" in
    1)
        warn "Deleting Neovim config..."
        rm -rf ~/.config/nvim/
        ;;
    2)
        warn "Backing up Neovim config..."
        if [ -d ~/.config/nvim ]; then
            mv ~/.config/nvim{,.bak}
        else
            error "No config found to backup."
        fi
        ;;
    3)
        info "Skipping config."
        ;;
    *)
        error "Invalid choice. Skipping config."
        ;;
    esac
}

# Function to handle Neovim cache cleanup (includes Mason)
clear_cache() {
    info "What do you want to do with your Neovim caches (including Mason)?"
    echo "  1) Delete (~/.local/share/state/cache/nvim + mason)"
    echo "  2) Backup to *.bak"
    echo "  3) Skip"
    read -rp "Choose an option (1-3): " choice

    case "$choice" in
    1)
        warn "Deleting Neovim caches..."
        rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
        ;;
    2)
        warn "Backing up Neovim caches..."
        for dir in ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
            if [ -d "$dir" ]; then
                mv "${dir}"{,.bak}
            else
                error "No cache found at $dir"
            fi
        done
        ;;
    3)
        info "Skipping caches."
        ;;
    *)
        error "Invalid choice. Skipping caches."
        ;;
    esac

    # Handle Mason cache cleanup separately for clarity
    info "What do you want to do with your Mason cache (~/.local/share/nvim/mason)?"
    echo "  1) Delete"
    echo "  2) Backup to mason.bak"
    echo "  3) Skip"
    read -rp "Choose an option (1-3): " mason_choice

    case "$mason_choice" in
    1)
        warn "Deleting Mason cache..."
        rm -rf ~/.local/share/nvim/mason
        ;;
    2)
        warn "Backing up Mason cache..."
        if [ -d ~/.local/share/nvim/mason ]; then
            mv ~/.local/share/nvim/mason{,.bak}
        else
            error "No Mason cache found to backup."
        fi
        ;;
    3)
        info "Skipping Mason cache."
        ;;
    *)
        error "Invalid choice. Skipping Mason cache."
        ;;
    esac
}

# Main
info "=== Neovim Cleanup Script ==="
clear_config
clear_cache
info "Done!"
