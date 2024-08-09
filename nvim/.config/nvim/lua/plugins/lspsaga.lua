return {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup {
            move_in_saga = {
                prev = "<C-k>",
                next = "<C-j>",
            },
            finder_action_keys = {
                open = "<CR>",
            },
            definition_action_keys = {
                edit = "<CR>",
            },
        }
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
}
