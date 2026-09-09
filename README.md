# Cross-Platform Dotfiles

A comprehensive, cross-platform dotfiles configuration for macOS and Linux (Wayland/Hyprland). Minimal, modular, and easy to install with a single command.

## Features

- **Cross-Platform**: Same dotfiles work on macOS and Linux
- **Modular Design**: Platform-specific overrides where needed
- **One-Command Install**: Bootstrap from a fresh system
- **Lightweight**: No oh-my-zsh, minimal dependencies
- **Modern Tools**: Alacritty, Neovim, Tmux, Starship, Zoxide, Eza

## Platforms

**macOS:**
- Terminal: Alacritty
- Shell: Zsh/Bash with Zap plugin manager
- Editor: Neovim (`nvim`) plus iOS overlay (`xim`)
- Multiplexer: Tmux with TPM
- Fonts: Nerd Fonts (Hack, Meslo)
- Tools: Homebrew, Node.js, Python, Ruby, Go

**Linux (Wayland):**
- Compositor: Hyprland
- Terminal: Alacritty, Foot
- Bar: Waybar
- Launcher: Rofi
- Notifications: Mako
- Lock Screen: Hyprlock / Swaylock
- Shell: Zsh/Bash (same config as macOS)
- Editor: Neovim (same config as macOS)

## Preview

<!-- TODO: Add macOS screenshot -->

<!-- TODO: Add Linux/Hyprland screenshot -->

## Installation

**One-liner (bootstraps if needed):**
```bash
sh <(curl -sL https://raw.githubusercontent.com/tomijaroli/dotfiles/main/install.sh)
```

**Or if already cloned:**
```bash
cd ~/dotfiles
./install.sh
```

The installer automatically detects your OS and installs the appropriate packages and configurations.

## What Gets Installed

### Common (macOS + Linux)
- **Shells**: Zsh + Bash (cross-platform configs)
- **Terminal**: Alacritty
- **Editor**: Neovim (`nvim` general, `xim` iOS)
- **Multiplexer**: Tmux with plugins
- **Tools**: Git, Starship, Zoxide, Eza, Bat, Fzf
- **Fonts**: Hack Nerd Font, Meslo Nerd Font

### macOS-Only
- **Homebrew**: Package manager + Brewfile
- **Xcode CLI Tools**: Command-line developer tools
- **Dock Manager**: Custom Dock profile switching
- **LLDB Config**: Enhanced debugger for iOS development

### Linux-Only
- **Hyprland**: Wayland compositor
- **Waybar**: Status bar
- **Rofi**: Application launcher
- **Mako**: Notification daemon
- **Foot**: Wayland-native terminal
- **Hyprlock/Swaylock**: Screen lockers
- **Wlogout**: Logout menu
- **GTK Themes**: Nordic, Graphite

## Structure

```
dotfiles/
├── install.sh              # Main installer (self-bootstrapping)
├── scripts/
│   ├── install/            # Modular installation scripts
│   │   ├── common.sh       # Shared functions & package lists
│   │   ├── macos.sh        # macOS-specific installation
│   │   └── linux.sh        # Linux-specific installation
│   ├── dock/               # Dock profile manager (macOS)
│   └── nvim/               # Neovim utility scripts
├── alacritty/              # Terminal config (cross-platform)
├── bash/                   # Bash config (cross-platform)
├── zsh/                    # Zsh config (cross-platform)
├── nvim/                   # Neovim config (cross-platform)
├── xim/                    # iOS Neovim overlay (macOS, NVIM_APPNAME=xim)
├── tmux/                   # Tmux config (cross-platform)
├── vim/                    # Vim config (cross-platform)
├── git/                    # Git config (cross-platform)
├── starship/               # Prompt config (cross-platform)
├── fonts/                  # Nerd Fonts
├── lldb/                   # LLDB config (macOS-only)
├── dock/                   # Dock profiles (macOS-only)
├── hypr/                   # Hyprland config (Linux-only)
├── waybar/                 # Waybar config (Linux-only)
├── rofi/                   # Rofi config (Linux-only)
├── mako/                   # Mako config (Linux-only)
├── foot/                   # Foot terminal config (Linux-only)
├── swaylock/               # Swaylock config (Linux-only)
├── wlogout/                # Wlogout config (Linux-only)
├── themes/                 # GTK themes (Linux-only)
└── wallpapers/             # Wallpapers (Linux-only)
```

Each directory contains a README with detailed configuration information.

## Key Configurations

### Shell (Bash/Zsh)
- **Cross-platform** with OS-specific overrides
- Modular structure: `exports.common`, `exports.macos`, `exports.linux`
- Same structure for aliases
- Zap plugin manager (lightweight alternative to oh-my-zsh)
- Integrations: Zoxide, Eza, Bat, Fzf, Starship

### Alacritty
- Common config with platform-specific imports
- macOS: MesloLGS NF, full decorations, opacity 1.0
- Linux: Meslo LGM Nerd Font, no decorations, opacity 0.8
- Nord color theme

### Neovim
- `nvim` — general editor: builtin LSP + completion, vim.pack, mini.pick, Oil, Treesitter
- `xim` — macOS overlay: sourcekit, xcodebuild.nvim, DAP (`alias xim`)
- Language servers and formatters from Homebrew / PATH (no Mason)

### Tmux
- Vi mode keybindings
- Custom Nord/OneDark themes
- Plugins: vim-tmux-navigator, resurrect, continuum
- System clipboard integration

## Post-Install

### Tmux Plugins
```bash
# Open tmux and press: prefix + I (capital i)
```

### Zsh Plugins
Automatically installed via Zap on first shell launch.

### Neovim
Plugins install on first `nvim` / `xim` launch (`vim.pack`). LSP binaries come from Homebrew (`brew bundle`). If this machine still has the previous lazy.nvim / Mason install, run `./scripts/nvim/clear-caches.sh` first.

## Customization

All configurations are modular and documented. See individual READMEs in each directory for customization options.

**Common customizations:**
- Shell aliases/exports: Edit `{bash,zsh}/.config/{bash,zsh}/aliases.*.{bash,zsh}`
- Neovim: Modify `nvim/.config/nvim/` (or `xim/.config/xim/` for iOS)
- Alacritty colors: Edit `alacritty/.config/alacritty/themes/`
- Tmux theme: Edit `tmux/.config/tmux/{nord,onedark}-theme.conf`

## Secrets Management

Create `.secrets.{bash,zsh}` files in `~/.config/{bash,zsh}/` for private environment variables (gitignored).

## License

MIT License - See [LICENSE](LICENSE) file for details.
