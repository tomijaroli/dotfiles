return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require "plugins.config.nvim-treesitter"
    end,
}
