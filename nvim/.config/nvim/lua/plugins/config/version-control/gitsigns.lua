return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "<leader>gp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "Git: Preview hunk",
    },
    {
      "<leader>gb",
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      desc = "Git: Toggle blame",
    },
  },
}
