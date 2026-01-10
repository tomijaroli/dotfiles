# Neovim Utility Scripts

Helper scripts for managing Neovim configuration and caches.

## Scripts

### `clear-caches.sh`

Interactive script to clean or backup Neovim data directories.

**What it handles:**
- **Config** (`~/.config/nvim/`) - Your Neovim configuration
- **Caches** (`~/.local/share/nvim/`, `~/.local/state/nvim/`, `~/.cache/nvim/`) - Plugin data, state, and caches
- **Mason** (`~/.local/share/nvim/mason/`) - LSP servers, formatters, linters installed by Mason

**Options for each:**
1. Delete completely
2. Backup to `*.bak`
3. Skip

**Usage:**

```bash
./scripts/nvim/clear-caches.sh
```

The script will prompt you interactively for each component.

## When to Use

- **Fresh start**: Delete everything to reset Neovim to a clean state
- **Testing changes**: Backup before major config updates
- **Troubleshooting**: Clear caches when experiencing plugin issues
- **Mason problems**: Clear Mason cache to reinstall LSP servers

## Cross-Platform

Works on macOS and Linux. The XDG cache directories are standard across both platforms.
