return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
	view_options = {
		show_hidden = true,
	}
  },
  keys = {
    {
      "-",
      function() require("oil").open_float() end,
      desc = "Open Oil (floating)",
      mode = "n",
    },
  },
  -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
}
