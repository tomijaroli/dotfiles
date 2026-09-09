local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
  }

  require("gitsigns").setup()
end)

lazyload.on_very_lazy(setup)

vim.keymap.set("n", "<leader>gp", function()
  setup()
  require("gitsigns").preview_hunk()
end, { desc = "Git: Preview hunk" })
vim.keymap.set("n", "<leader>gb", function()
  setup()
  require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle blame" })
