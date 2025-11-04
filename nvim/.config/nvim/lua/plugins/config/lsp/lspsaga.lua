return {
  "nvimdev/lspsaga.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    move_in_saga = {
      prev = "<C-k>",
      next = "<C-j>",
    },
    finder_action_keys = {
      open = "<CR>",
    },
    definition_action_keys = {
      edit = "<CR>",
    },
    ui = {
      title = true,
    },
    beacon = {
      enable = true,
    },
    symbol_in_winbar = {
      enable = true,
      separator = "  ",
    },
    outline = {
      win_position = "right",
      show_detail = true,
    },
    diagnostic = {
      on_insert = false,
    },
  },
  -- config = function(_, opts)
  --     local status_ok, saga = pcall(require, "lspsaga")
  --     if not status_ok then
  --         return
  --     end
  --     saga.setup(opts)
  -- end,
}
