# Tmux Configuration

This directory contains the configuration for **tmux**, a terminal multiplexer that allows you to manage multiple terminal sessions within a single window. It's fully cross-platform compatible.

## Structure

```
tmux/
  .tmux.conf                      # Main tmux configuration
  .config/tmux/
    nord-theme.conf               # Nord color theme
    onedark-theme.conf            # OneDark color theme
```

## How It Works

Tmux is configured via `.tmux.conf`, which defines keybindings, visual settings, plugins, and behavior. The configuration is **cross-platform compatible**, working identically on macOS and Linux.

### Configuration Highlights

**General Settings:**
- **Base Index**: Windows and panes start at 1 (not 0)
- **True Color**: Supports RGB colors for Alacritty and other modern terminals
- **History**: 1,000,000 lines of scrollback
- **Mouse Support**: Enabled for scrolling, pane selection, and resizing
- **Clipboard**: System clipboard integration
- **Vi Mode**: Vi-style keybindings for copy mode

**Custom Keybindings:**
- **Prefix**: Default `Ctrl+b` (can be customized)
- `r` - Reload tmux config
- `%` - Split horizontally (maintains current path)
- `"` - Split vertically (maintains current path)
- `c` - New window (maintains current path)
- `h/j/k/l` - Resize panes (repeatable)
- `m` - Maximize/minimize pane
- `x` - Kill pane (no confirmation prompt)
- `e` - Edit scrollback in Neovim

**Copy Mode (Vi-style):**
- `Ctrl+[` - Enter copy mode
- `v` - Begin selection
- `y` - Copy selection
- `P` - Paste buffer
- `Ctrl+h/j/k/l` - Navigate panes in copy mode
- Mouse drag selection is supported

**Theme:**
- **Active**: Nord theme (loaded from `~/.config/tmux/nord-theme.conf`)
- **Alternative**: OneDark theme available
- **Status Bar**: Top position, session name, window list, hostname

**Plugins (TPM - Tmux Plugin Manager):**
- `vim-tmux-navigator` - Seamless navigation between tmux panes and vim splits
- `tmux-resurrect` - Save and restore tmux sessions
- `tmux-continuum` - Automatic session saving (restore disabled by default)

## Cross-Platform Compatibility

This tmux configuration is **fully cross-platform compatible**. It works identically on:
- macOS
- Linux
- WSL (Windows Subsystem for Linux)

The configuration uses the user's default shell (`$SHELL`), so it adapts automatically to your environment.

## Usage

**Sessions:**
- `tmux new -s <name>` - Create new session
- `tmux attach -t <name>` - Attach to session
- `tmux ls` - List sessions
- `prefix + s` - List sessions (interactive)

**Windows:**
- `prefix + c` - Create window
- `prefix + n/p` - Next/previous window
- `prefix + ,` - Rename window

**Panes:**
- `prefix + %` - Split horizontally
- `prefix + "` - Split vertically
- `prefix + h/j/k/l` - Resize pane
- `prefix + m` - Maximize/minimize pane

**Plugins:**
- `prefix + I` - Install plugins (first time setup)
- `prefix + U` - Update plugins

## Customization

-   **Prefix Key**: Uncomment and modify the prefix binding in `.tmux.conf` if you prefer a different key.
-   **Theme**: Change the `source-file` line to load `onedark-theme.conf` instead of `nord-theme.conf`.
-   **Shell**: By default uses `$SHELL` environment variable (Zsh or Bash).
-   **Plugins**: Add more plugins by adding `set -g @plugin 'user/repo'` lines before the TPM initialization.

## Installation Notes

- **TPM**: The configuration expects TPM (Tmux Plugin Manager) to be installed at `~/.tmux/plugins/tpm/`.
- **First Run**: After installation, press `prefix + I` to install all plugins.
- **Theme Changes**: Run `tmux kill-server && rm -rf /tmp/tmux-*` to apply theme changes.
