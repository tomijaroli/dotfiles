local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/stevearc/oil.nvim" },
  }

  require("oil").setup {
    view_options = {
      show_hidden = true,
    },
  }
end)

vim.keymap.set("n", "-", function()
  setup()
  require("oil").open_float()
end, { desc = "Open Oil (floating)" })
