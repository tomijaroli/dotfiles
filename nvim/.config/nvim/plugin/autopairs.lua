local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/windwp/nvim-autopairs" },
  }

  require("nvim-autopairs").setup {}
end)

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("user-autopairs", { clear = true }),
  once = true,
  callback = function()
    setup()
    pcall(function()
      require("nvim-autopairs").on_attach()
    end)
  end,
})
