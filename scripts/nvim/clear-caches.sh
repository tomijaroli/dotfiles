#!/usr/bin/env bash

info() { echo -e "\033[1;34m$1\033[0m"; }
warn() { echo -e "\033[1;33m$1\033[0m"; }
error() { echo -e "\033[1;31m$1\033[0m"; }

APPS=(nvim xim)

clear_configs() {
    info "What do you want to do with Neovim configs?"
    echo "  1) Delete (~/.config/nvim and ~/.config/xim)"
    echo "  2) Backup to *.bak"
    echo "  3) Skip"
    read -rp "Choose an option (1-3): " choice

    case "$choice" in
    1)
        warn "Deleting Neovim configs..."
        rm -rf ~/.config/nvim ~/.config/xim
        ;;
    2)
        warn "Backing up Neovim configs..."
        for app in "${APPS[@]}"; do
            if [ -e "$HOME/.config/$app" ]; then
                mv "$HOME/.config/$app" "$HOME/.config/${app}.bak"
            else
                error "No config found at ~/.config/$app"
            fi
        done
        ;;
    3)
        info "Skipping configs."
        ;;
    *)
        error "Invalid choice. Skipping configs."
        ;;
    esac
}

clear_data() {
    info "What do you want to do with Neovim data (plugins, state, cache)?"
    echo "  1) Delete (~/.local/share/{nvim,xim}, state, cache)"
    echo "  2) Backup to *.bak"
    echo "  3) Skip"
    read -rp "Choose an option (1-3): " choice

    local dirs=()
    for app in "${APPS[@]}"; do
        dirs+=("$HOME/.local/share/$app" "$HOME/.local/state/$app" "$HOME/.cache/$app")
    done

    case "$choice" in
    1)
        warn "Deleting Neovim data..."
        rm -rf "${dirs[@]}"
        ;;
    2)
        warn "Backing up Neovim data..."
        for dir in "${dirs[@]}"; do
            if [ -d "$dir" ]; then
                mv "${dir}"{,.bak}
            else
                error "No directory found at $dir"
            fi
        done
        ;;
    3)
        info "Skipping data."
        ;;
    *)
        error "Invalid choice. Skipping data."
        ;;
    esac
}

info "=== Neovim Cleanup Script ==="
clear_configs
clear_data
info "Done!"
