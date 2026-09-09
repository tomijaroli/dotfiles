local lazyload = require "lazyload"

lazyload.on_very_lazy(function()
  vim.pack.add {
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  }

  require("ibl").setup {
    scope = { enabled = false },
  }
end)
