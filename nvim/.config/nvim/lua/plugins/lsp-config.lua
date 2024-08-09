return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "j-hui/fidget.nvim",
            event = "VeryLazy",
            opts = {
                notification = {
                    window = {
                        normal_hl = "String",
                        winblend = 0,
                        border = "rounded",
                        zindex = 45,
                        max_width = 0,
                        max_height = 0,
                        x_padding = 1,
                        y_padding = 1,
                        align = "bottom",
                        relative = "editor",
                    },
                },
            },
        },
    },
    config = function()
        require "plugins.config.lsp"
    end,
}
