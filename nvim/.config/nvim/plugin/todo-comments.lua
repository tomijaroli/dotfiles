local lazyload = require "lazyload"

lazyload.on_very_lazy(function()
  vim.pack.add {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
  }

  require("todo-comments").setup {
    signs = false,
  }
end)
