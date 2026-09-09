require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
  }

  require("gitsigns").setup()

  vim.keymap.set("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
  end, { desc = "Git: Preview hunk" })
  vim.keymap.set("n", "<leader>gb", function()
    require("gitsigns").toggle_current_line_blame()
  end, { desc = "Git: Toggle blame" })
end)
