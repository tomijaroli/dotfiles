return {
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require "plugins.config.conform"
        end,
    },
    {
        "gennaro-tedesco/nvim-jqx",
        ft = { "json" },
    },
}
