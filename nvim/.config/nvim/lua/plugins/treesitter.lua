return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {},
    config = function()
        require "plugins.config.nvim-treesitter"
    end,
}
