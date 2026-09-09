# Neovim Utility Scripts

### `clear-caches.sh`

Wipe plugin installs and caches for `nvim` and `xim` **without** touching `~/.config`. Use after this repo is checked out / stowed on a machine that still has the old lazy.nvim / Mason data.

Removes (if present):

- `~/.local/share/{nvim,xim}` — lazy.nvim, Mason, packer, vim.pack clones, treesitter parsers
- `~/.local/state/{nvim,xim}` — shada, logs
- `~/.cache/{nvim,xim}` — luacache and other caches

Respects `XDG_DATA_HOME`, `XDG_STATE_HOME`, and `XDG_CACHE_HOME`.

```bash
./scripts/nvim/clear-caches.sh           # confirm, then delete
./scripts/nvim/clear-caches.sh --dry-run
./scripts/nvim/clear-caches.sh --yes     # no prompt
```

Then open `nvim` (and `xim` on macOS). Plugins reinstall from `nvim-pack-lock.json`. LSP binaries stay on PATH (Homebrew); they are not in these directories.
