local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/folke/which-key.nvim" },
  }

  require("which-key").setup {}
end)

lazyload.on_very_lazy(setup)

vim.keymap.set("n", "<leader>?", function()
  setup()
  require("which-key").show { global = false }
end, { desc = "Buffer Local Keymaps (which-key)" })
