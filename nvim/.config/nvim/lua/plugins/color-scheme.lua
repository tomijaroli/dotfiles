local theme = require "plugins.config.nord"

return {
  theme.repository,
  name = theme.name,
  priority = theme.priority,
  lazy = theme.lazy,
  opts = theme.opts,
  config = function()
    vim.cmd.colorscheme(theme.name)
    vim.cmd.hi "Comment gui=none"
  end,
}

-- Some nice themes:

-- "catppuccin/nvim",
-- "sainnhe/everforest",
-- "sainnhe/gruvbox-material",
-- "folke/tokyonight.nvim",
-- "cocopon/iceberg.vim",
-- "bluz71/vim-nightfly-colors",
-- "EdenEast/nightfox.nvim",
-- "arcticicestudio/nord-vim",
-- "jacoborus/tender.vim",
