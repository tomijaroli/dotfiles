return {
    "tpope/vim-sleuth",
    "tpope/vim-surround",
    "windwp/nvim-ts-autotag",
    "vim-scripts/ReplaceWithRegister",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        opts = {
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        opts = {
            check_ts = true,
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                java = false,
            },
            fast_wrap = {
                map = "<M-e>",
                chars = { "{", "[", "(", '"', "'" },
                pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                offset = 0,
                end_key = "$",
                keys = "qwertyuiopzxcvbnmasdfghjkl",
                check_comma = true,
                highlight = "PmenuSel",
                highlight_grey = "LineNr",
            },
        },
        config = function(_, opts)
            local autopairs = require "nvim-autopairs"
            autopairs.setup(opts)

            if not vim.g.autopairs_enabled then
                autopairs.disable()
            end

            local cmp_autopairs_setup, cmp = pcall(require, "cmp")
            if cmp_autopairs_setup then
                cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false })
            end
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
