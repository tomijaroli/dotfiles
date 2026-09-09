local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  }

  require("colorizer").setup {
    "css",
    "html",
    "javascript",
  }
end)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-colorizer", { clear = true }),
  pattern = { "css", "html", "javascript" },
  callback = function(event)
    setup()
    require("colorizer").attach_to_buffer(event.buf)
  end,
})
