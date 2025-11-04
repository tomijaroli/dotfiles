M = {}

M.repository = 'stevearc/oil.nvim'
---@module 'oil'
---@type oil.SetupOpts
M.opts = {
  view_options = {
	show_hidden = true,
  }
}
M.keys = {
  {
    "-",
    function() require("oil").open_float() end,
    desc = "Open Oil (floating)",
    mode = "n",
  },
}
M.dependencies = { "nvim-tree/nvim-web-devicons" }
-- M.dependencies = { { "nvim-mini/mini.icons", opts = {} } },
M.lazy = false

return M
