-- Colorscheme must load during startup, not on VimEnter.
vim.pack.add {
  { src = "https://github.com/EdenEast/nightfox.nvim" },
}

vim.cmd.colorscheme "nordfox"
