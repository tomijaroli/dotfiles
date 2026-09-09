# Neovim Utility Scripts

### `clear-caches.sh`

Interactive cleanup for both Neovim apps (`nvim` and `xim`).

**Config:** `~/.config/nvim`, `~/.config/xim`  
**Data:** `~/.local/share/{nvim,xim}` (vim.pack plugins), `~/.local/state/{nvim,xim}`, `~/.cache/{nvim,xim}`

Options: delete, backup to `*.bak`, or skip.

```bash
./scripts/nvim/clear-caches.sh
```

LSP servers are **not** stored here; they come from Homebrew / the system PATH. After deleting plugin data, the next `nvim` / `xim` launch re-clones plugins from the lockfiles.
