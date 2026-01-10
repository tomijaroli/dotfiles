# Vim Configuration

This directory contains the configuration for **Vim**, a highly configurable text editor. The configuration is minimal, plugin-free, and fully cross-platform compatible.

## Structure

```
vim/
  .vimrc    # Main Vim configuration
```

## How It Works

Vim is configured via `.vimrc`, which defines settings, keybindings, and behavior. This configuration is **cross-platform compatible**, working identically on macOS and Linux.

### Configuration Highlights

**Leader Key:** `Space`

**Appearance:**
- **Line Numbers**: Relative line numbers enabled
- **Colorscheme**: `slate` (dark background)
- **True Colors**: Enabled for modern terminals (Alacritty, Tmux)
- **Cursor Line**: Current line highlighted
- **Cursor Style**: Line cursor in insert mode, block cursor in normal mode

**Indentation:**
- **Tab Size**: 4 spaces
- **Expand Tabs**: Converts tabs to spaces
- **Smart Indent**: Automatic and smart indentation

**Search:**
- **Case Insensitive**: Unless search contains uppercase
- **Highlight**: Search results highlighted

**Splits & Windows:**
- **Split Below**: Horizontal splits open below
- **Split Right**: Vertical splits open to the right

**Clipboard:**
- **System Clipboard**: Automatically syncs with OS clipboard
  - macOS: Uses `unnamed`
  - Linux: Uses `unnamedplus`

**Mouse:** Enabled for scrolling and selection

**Undo:** Persistent undo history saved to file

### Key Bindings

**General:**
- `jk` - Exit insert mode
- `<Esc>` - Clear search highlights
- `<leader>wt` - Toggle line wrapping

**Navigation:**
- `j/k` - Move by visual line (wrapped lines)
- `<C-h/j/k/l>` - Navigate between splits

**Buffers:**
- `<Tab>` - Next buffer
- `<S-Tab>` - Previous buffer
- `<leader>sb` - Show buffers and select
- `<leader>x` - Close buffer
- `<leader>b` - New buffer

**Tabs:**
- `<leader>to` - New tab
- `<leader>tx` - Close tab
- `<leader>tn` - Next tab
- `<leader>tp` - Previous tab

**Editing:**
- `<` / `>` (visual) - Indent and keep selection
- `x` - Delete without copying to register
- `p` (visual) - Paste without losing yank
- `<leader>y` / `<leader>Y` - Yank to system clipboard

**File Explorer (Netrw):**
- `<leader>e` - Open file explorer (Netrw) in left sidebar
- `l` - Open file/directory (in Netrw)
- Netrw configured with tree-style listing and no banner

## Cross-Platform Compatibility

This Vim configuration is **fully cross-platform compatible**. It works identically on:
- macOS
- Linux
- WSL (Windows Subsystem for Linux)

The only OS-specific adjustment is for clipboard integration, which is automatically detected:
- **macOS**: Uses `set clipboard=unnamed`
- **Linux**: Uses `set clipboard=unnamedplus`

## Usage

After installation, simply run `vim` to use the editor with your custom configuration.

```bash
vim myfile.txt
```

## Customization

-   **Colorscheme**: Change `colorscheme slate` to any built-in colorscheme (e.g., `desert`, `evening`, `pablo`).
-   **Indentation**: Adjust `tabstop`, `shiftwidth`, and `expandtab` for different indentation preferences.
-   **Keybindings**: Add or modify keybindings in the "Keymaps" section.
-   **Plugins**: This configuration is intentionally plugin-free. If you want plugins, consider using a plugin manager like `vim-plug` or switch to Neovim.

## Notes

- **No Plugins**: This configuration is deliberately minimal and plugin-free for maximum portability.
- **Netrw**: Uses Vim's built-in file explorer instead of NERDTree or other plugins.
- **Neovim**: For a more feature-rich, plugin-based setup, see the `nvim/` configuration.
