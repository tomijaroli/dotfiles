# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Cross-platform dotfiles for macOS and Linux (Wayland/Hyprland), managed with GNU Stow. Each top-level directory is a stow package — its contents mirror the target `$HOME` tree and are symlinked there by the installer.

## Installation

```bash
# Fresh system (self-bootstrapping)
sh <(curl -sL https://raw.githubusercontent.com/tomijaroli/dotfiles/main/install.sh)

# Already cloned
./install.sh
```

The installer auto-detects macOS vs Linux and calls `run_macos_install` or `run_linux_install` from `scripts/install/macos.sh` / `scripts/install/linux.sh`. Shared utilities live in `scripts/install/common.sh`.

### Manually stow/unstow a package

```bash
stow <package>          # link package into $HOME
stow -D <package>       # unlink
stow -R <package>       # re-link (unlink then link)
```

## Package Layout

Each directory is a stow package. The mapping is:

| Directory | Platform | Stowed to |
|-----------|----------|-----------|
| `alacritty/`, `bash/`, `zsh/`, `git/`, `nvim/`, `tmux/`, `vim/`, `starship/`, `dircolors/` | Both | `~/.config/…` |
| `dock/`, `lldb/` | macOS only | `~/.config/…` |
| `hypr/`, `waybar/`, `rofi/`, `mako/`, `foot/`, `swaylock/`, `wlogout/`, `electron/`, `fastfetch/`, `greetd/`, `themes/`, `wallpapers/` | Linux only | varies |

After stowing, the Alacritty platform config must be symlinked:
```bash
# macOS
ln -sf ~/.config/alacritty/alacritty.macos.toml ~/.config/alacritty/alacritty.toml
# Linux
ln -sf ~/.config/alacritty/alacritty.linux.toml ~/.config/alacritty/alacritty.toml
```

## Shell Config Architecture

`zsh/.zshrc` loads via [Zap](https://github.com/zap-zsh/zap) plugin manager. Load order:

1. `exports.common.zsh` → `exports.{macos,linux}.zsh`
2. `aliases.common.zsh` → `aliases.{macos,linux}.zsh`
3. `~/.config/zsh/.secrets.zsh` (gitignored, for private env vars)

Files live under `zsh/.config/zsh/`. The same modular pattern applies to `bash/.config/bash/`.

## Neovim Config Architecture

Entry point: `nvim/.config/nvim/init.lua` — loads five modules from `lua/config/`.

Plugin system: **lazy.nvim** auto-bootstrapped in `lua/config/lazy.lua`, specs imported from `lua/plugins/`.

Language support is centralized in `lua/plugins/config/lsp/languages.lua` — a single table defines treesitter grammar, LSP server, formatters, and linters per filetype. To add a new language, add an entry there; `lsp-config.lua`, `conform.lua`, and `nvim-lint.lua` iterate over it automatically.

Neovim itself is managed with **bob** (version manager):
```bash
bob install nightly
bob use nightly
```

Clear caches/reset plugins:
```bash
./scripts/nvim/clear-caches.sh
```

## macOS-Specific Tools

### Homebrew

```bash
brew bundle install --file=Brewfile   # install all packages
brew bundle check --file=Brewfile     # verify everything is installed
```

Key tools in Brewfile: `bob` (nvim manager), `stow`, `starship`, `zoxide`, `eza`, `bat`, `fzf`, `ripgrep`, `lazygit`, `tmux`, `nvm`, `swiftlint`, `swiftformat`, `xcodegen`, `xcode-build-server`.

### Dock Profile Manager

Three profiles: `default`, `dev`, `studio`. Profiles stored as plists under `dock/.config/dock/`.

```bash
dock default | dock dev | dock studio   # switch profile
dock-export <profile>                    # export current Dock state to profile
```

Scripts live in `scripts/dock/`; installed to `~/.local/bin` by `install-dock-profile-manager.sh`.

## Post-Install Checklist

- **Tmux plugins**: open tmux → `prefix + I`
- **Zsh plugins**: auto-installed by Zap on first shell launch
- **Neovim LSP servers**: auto-installed by Mason on first file open
- **Secrets**: create `~/.config/zsh/.secrets.zsh` (and/or `~/.config/bash/.secrets.bash`) for private env vars

## Git Config Notes

`git/.gitconfig` includes an untracked `~/.gitconfig.local` (via `[include] path = ~/.gitconfig.local`) for machine-specific overrides that shouldn't be committed — e.g. work email/signing key.

GPG signing via SSH key using [Secretive](https://github.com/maxgoedjen/secretive) is work-specific, not part of the shared dotfiles. On a work laptop, `~/.gitconfig.local` sets `user.email`, `user.signingkey`, `commit.gpgsign = true`, `gpg.format = ssh`, and `gpg.ssh.allowedSignersFile`. If signing fails on a new work machine, Secretive must be running and the key re-exported.
