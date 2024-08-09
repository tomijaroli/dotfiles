return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "plugins.config.gitsigns"
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "lg", "<cmd>LazyGit<CR>", desc = "Open lazygit" },
    },
  },
}
