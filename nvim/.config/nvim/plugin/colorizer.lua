require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  }

  require("colorizer").setup()
end)
