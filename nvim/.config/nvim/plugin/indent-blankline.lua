require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  }

  require("ibl").setup {
    scope = { enabled = false },
  }
end)
