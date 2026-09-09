# Neovim

General-purpose editor for Neovim 0.13+ (bob nightly). Plugins via builtin `vim.pack`. LSP configs are vendored in `lsp/`; binaries come from the system PATH.

iOS / Xcode tooling lives in a second app: [`xim`](../../../xim/.config/xim/README.md) (`NVIM_APPNAME=xim`).

## Structure

```
init.lua                 # Entry
nvim-pack-lock.json      # vim.pack lockfile (commit this)
lua/
  config/                # options, keymaps, globals, autocmds
  languages.lua          # treesitter / format / lint registry
  lazyload.lua           # VimEnter plugin queue
lsp/                     # vim.lsp.config files (lua_ls, bashls, html, jsonls, yamlls)
plugin/                  # one file per plugin (vim.pack.add + setup)
after/ftplugin/
```

## Two apps

| Command | Config | Data |
| --- | --- | --- |
| `nvim` | `~/.config/nvim` | `~/.local/share/nvim` |
| `xim` (`NVIM_APPNAME=xim nvim`) | `~/.config/xim` | `~/.local/share/xim` |

`xim` prepends this config on `runtimepath` and adds Swift / xcodebuild / DAP.

## System tools

Install with Homebrew (`brew bundle`) or the Linux equivalents. Neovim does not install language servers.

**macOS (Brewfile):** `lua-language-server`, `bash-language-server`, `vscode-langservers-extracted` (html/json), `yaml-language-server`, `stylua`, `luacheck`, `shfmt`, `shellcheck`, `prettier`, `rubocop`, `tree-sitter`, `tree-sitter-cli`, `ripgrep`, `lazygit`

**Linux:** same names via npm (`bash-language-server`, `vscode-langservers-extracted`, `yaml-language-server`, `prettier`) or distro packages (`lua-language-server`, `stylua`, `shfmt`, `shellcheck`, `ripgrep`).

Check with `:checkhealth vim.lsp`.

## Plugins

`vim.pack` clones into `stdpath("data")/site/pack/core/opt`. First launch installs from `nvim-pack-lock.json`. Update with `:lua vim.pack.update()`.

Kept plugins: nightfox, nvim-treesitter (`main`), conform, nvim-lint, telescope + fzf-native, oil, gitsigns, lualine.

Completion is builtin (`vim.lsp.completion`). Format-on-save is Conform (CLI formatters, not LSP format).

Add a plugin by creating `plugin/<name>.lua` that calls `vim.pack.add` (defer with `require("lazyload").on_vim_enter` unless it must load at startup, e.g. colorscheme).

## Key bindings

**Leader:** `Space`

**General:** `jk` insert-exit, `<Esc>` clear search, `<leader>wt` wrap, `-` Oil, `<leader>tt` floating terminal, `lg` lazygit (`:terminal`)

**Buffers:** `<Tab>` / `<S-Tab>`, `<leader>bd`, `<leader><leader>` Telescope buffers

**Telescope:** `<leader>ff` files, `<leader>fg` grep, `<leader>fh` help, `<leader>fk` keymaps, `<leader>fs` builtins, `<leader>fd` diagnostics, `<leader>/` buffer, `<leader>fn` nvim config

**LSP (defaults + Telescope):** `grn` rename, `gra` code action, `grd` definition, `grr` references, `gri` implementation, `grt` type, `gO` document symbols, `gW` workspace symbols, `<C-Space>` completion, `<leader>th` inlay hints

**Git:** `<leader>gp` hunk preview, `<leader>gb` blame

**Diagnostics:** `<leader>de` float, `<leader>q` loclist, `<leader>Q` qflist, `<leader>ml` lint

## Requirements

Neovim 0.13+ (this repo installs nightly via bob).
