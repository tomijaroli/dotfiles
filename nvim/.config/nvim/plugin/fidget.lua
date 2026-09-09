local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/j-hui/fidget.nvim" },
  }

  require("fidget").setup {
    notification = {
      window = {
        normal_hl = "String",
        winblend = 0,
        border = "rounded",
        zindex = 45,
        max_width = 0,
        max_height = 0,
        x_padding = 1,
        y_padding = 1,
        align = "bottom",
        relative = "editor",
      },
    },
  }
end)

vim.api.nvim_create_autocmd({ "LspAttach", "LspProgress" }, {
  group = vim.api.nvim_create_augroup("user-fidget", { clear = true }),
  once = true,
  callback = setup,
})
