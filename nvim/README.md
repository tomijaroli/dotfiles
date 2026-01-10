# Neovim Configuration

Modern Neovim configuration with LSP, Treesitter, and custom keybindings.

## Structure

```
nvim/
  .config/nvim/
    init.lua                    # Entry point
    lua/
      config/
        lazy.lua                # Lazy.nvim plugin manager
        options.lua             # Editor options
        keymaps.lua             # Key bindings
        autocommands.lua        # Auto commands
        globals.lua             # Global variables
      plugins/                  # Plugin configurations
    plugin/
      floating-terminal.lua     # Custom floating terminal
```

## Platform Compatibility

**Fully cross-platform** - Works identically on macOS and Linux.

**Clipboard handling:**
- Automatically uses system clipboard via `unnamedplus`
- Neovim detects the right clipboard provider (pbcopy/xclip)

## Key Features

- **LSP** - Language Server Protocol support
- **Treesitter** - Syntax highlighting and parsing
- **Lazy.nvim** - Modern plugin manager
- **Git integration** - Fugitive, Gitsigns
- **Fuzzy finding** - Telescope
- **File explorer** - Neo-tree or Nvim-tree
- **Auto-completion** - nvim-cmp
- **Floating terminal** - Custom implementation

## Key Bindings

**Leader key:** `Space`

**General:**
- `jk` - Exit insert mode
- `<Esc>` - Clear search highlight
- `<leader>wt` - Toggle word wrap

**Navigation:**
- `j/k` - Move by visual line (wrapped)
- `<C-h/j/k/l>` - Navigate splits
- Arrow keys disabled (use hjkl)
- `-` - File explorer (Oil.nvim, floating)

**Buffers:**
- `<Tab>` - Next buffer
- `<S-Tab>` - Previous buffer  
- `<leader>bd` - Close buffer
- `<leader><leader>` - Find existing buffers (Telescope)

**Editing:**
- `<` / `>` (visual) - Indent and keep selection
- `gG` - Select all
- `x` - Delete without yank
- `c/C` - Change without yank

**Clipboard:**
- `y` - Yank to system clipboard
- `d` - Delete to system clipboard

**Telescope (Finder):**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search text)
- `<leader>fh` - Help tags
- `<leader>fk` - Keymaps
- `<leader>fs` - Select Telescope builtin
- `<leader>fd` - Diagnostics
- `<leader>ft` - Todo comments
- `<leader>/` - Current buffer fuzzy find
- `<leader>fn` - Find Neovim config files

**Terminal:**
- `<leader>tt` - Toggle floating terminal
- `<Esc><Esc>` - Exit terminal mode

**Diagnostics:**
- `<leader>de` - Show diagnostic float
- `<leader>q` - Local diagnostics list
- `<leader>Q` - Global diagnostics list

**Development:**
- `<leader>o` - Save and reload file
- `<leader>s` - Execute current line (Lua)
- `<leader><leader>s` - Execute current file

## Installation

The installer automatically:
1. Installs Neovim via package manager
2. Stows the configuration
3. Plugins install on first launch (Lazy.nvim)

## First Launch

```bash
nvim
```

Lazy.nvim will automatically:
1. Install itself
2. Install all configured plugins
3. Set up LSP servers

## Customization

**Add plugins:**
Create files in `lua/plugins/` - Lazy.nvim auto-loads them.

**Change options:**
Edit `lua/config/options.lua`

**Add keybindings:**
Edit `lua/config/keymaps.lua`

## Notes

- Uses Lua (not Vimscript) for configuration
- Lazy loading for fast startup
- LSP servers need separate installation (Mason.nvim recommended)
- Clipboard works automatically on both platforms
- Compatible with Neovim 0.9+
