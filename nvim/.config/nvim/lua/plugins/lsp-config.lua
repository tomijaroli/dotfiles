return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            event = "VeryLazy",
            config = function()
                require "plugins.config.fidget"
            end,
        },
    },
    config = function()
        require "plugins.config.lsp"
    end,
}
