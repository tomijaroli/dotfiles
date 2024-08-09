return {
    "tpope/vim-sleuth",
    "tpope/vim-surround",
    "windwp/nvim-ts-autotag",
    "vim-scripts/ReplaceWithRegister",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        config = function()
            require "plugins.config.indent-blankline"
        end,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require "plugins.config.autopairs"
        end,
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        opts = { signs = false },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
}
