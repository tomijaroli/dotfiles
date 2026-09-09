require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/folke/which-key.nvim" },
  }

  require("which-key").setup {}

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show { global = false }
  end, { desc = "Buffer Local Keymaps (which-key)" })
end)
