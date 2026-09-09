local lazyload = require "lazyload"

local setup = lazyload.once(function()
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lspsaga", { clear = true }),
  once = true,
  callback = setup,
})
