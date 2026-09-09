require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvimdev/lspsaga.nvim" },
  }

  require("lspsaga").setup {
    ui = { title = true },
    beacon = { enable = true },
    symbol_in_winbar = {
      enable = true,
      separator = "  ",
    },
    outline = {
      win_position = "right",
      detail = true,
    },
  }
end)
