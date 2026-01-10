# Installation Scripts

Modular installation system for cross-platform dotfiles setup. These scripts are sourced by the main `install.sh` in the repository root.

## Structure

```
scripts/install/
├── common.sh    # Shared functions and package lists
├── macos.sh     # macOS-specific installation
└── linux.sh     # Linux-specific installation
```

## How It Works

1. **Main installer** (`~/dotfiles/install.sh`) detects the OS
2. Sources `common.sh` for shared utilities and package definitions
3. Sources and runs the appropriate platform script (`macos.sh` or `linux.sh`)

## common.sh

**Provides:**
- Logging functions (info, success, warning, error)
- Package lists:
  - `COMMON_STOW_PACKAGES` - Cross-platform configs (alacritty, bash, git, nvim, tmux, vim, zsh, etc.)
  - `MACOS_STOW_PACKAGES` - macOS-only (dock, lldb)
  - `LINUX_STOW_PACKAGES` - Linux-only (hypr, waybar, rofi, mako, foot, etc.)
- Helper functions:
  - `command_exists()` - Check if command is available
  - `install_zap()` - Install Zap plugin manager for Zsh
  - `install_tpm()` - Install Tmux Plugin Manager
  - `backup_shell_configs()` - Backup existing shell configs
  - `stow_common_packages()` - Stow cross-platform configs
  - `setup_alacritty_config()` - Create platform-specific Alacritty symlink
  - `install_fonts()` - Install Nerd Fonts
  - `install_node()` - Install Node.js via NVM

## macos.sh

**Installation steps:**
1. Install Xcode Command Line Tools
2. Install/update Homebrew
3. Install packages via Brewfile
4. Install Zap (Zsh) and TPM (Tmux)
5. Backup existing shell configs
6. Stow common + macOS packages
7. Setup Alacritty for macOS
8. Configure Terminal fonts
9. Install Dock profile manager
10. Install Nerd Fonts
11. Install Node.js

**Key functions:**
- `install_xcode_cli()` - Installs Xcode CLI tools
- `install_homebrew()` - Installs/updates Homebrew
- `install_brew_packages()` - Runs `brew bundle` with Brewfile
- `configure_terminal_fonts()` - Installs fonts to macOS
- `install_dock_config()` - Symlinks dock scripts to `~/.local/bin`

## linux.sh

**Installation steps:**
1. Detect Linux distribution (Arch, Debian/Ubuntu, Fedora, etc.)
2. Install AUR helper (yay) on Arch
3. Install packages via native package manager
4. Install NVM (Linux paths)
5. Install Zap (Zsh) and TPM (Tmux)
6. Backup existing shell configs
7. Stow common + Linux packages
8. Setup Alacritty for Linux
9. Setup Hyprland (if on Wayland)
10. Install Nerd Fonts
11. Install Node.js

**Key functions:**
- `detect_distro()` - Detects Linux distribution
- `install_aur_helper()` - Installs yay on Arch Linux
- `install_linux_packages()` - Installs packages based on distro
- `install_nvm_linux()` - Installs NVM for Linux
- `setup_hyprland()` - Post-install setup for Hyprland

## Usage

These scripts are not meant to be run directly. Use the main installer:

```bash
# One-liner install (bootstraps if needed)
sh <(curl -sL https://raw.githubusercontent.com/tomijaroli/dotfiles/main/install.sh)

# Or if already cloned
cd ~/dotfiles
./install.sh
```

## Customization

**Add new packages:**
- Edit `COMMON_STOW_PACKAGES`, `MACOS_STOW_PACKAGES`, or `LINUX_STOW_PACKAGES` in `common.sh`

**Modify installation steps:**
- Edit `run_macos_install()` in `macos.sh`
- Edit `run_linux_install()` in `linux.sh`

**Add new helper functions:**
- Add to `common.sh` for cross-platform utilities
- Add to platform-specific scripts for OS-specific logic

## Notes

- All scripts use `set -e` for fail-fast behavior
- Logging functions provide colored output for better readability
- The installer is idempotent - safe to run multiple times
- Backups are created before overwriting existing configs
