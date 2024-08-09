vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
        vim.opt_local.colorcolumn = ""
    end,
})

return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    config = function()
        local oil = require "oil"
        oil.setup {
            view_options = {
                show_hidden = true,
            },
        }
        vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
    end,
}
