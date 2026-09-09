require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/stevearc/oil.nvim" },
  }

  require("oil").setup {
    view_options = {
      show_hidden = true,
    },
  }

  vim.keymap.set("n", "-", function()
    require("oil").open_float()
  end, { desc = "Open Oil (floating)" })
end)
