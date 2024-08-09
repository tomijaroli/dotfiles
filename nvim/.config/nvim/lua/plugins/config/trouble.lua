require("trouble").setup {
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_jump = {},
    mode = "quickfix",
    severity = vim.diagnostic.severity.ERROR,
    cycle_results = false,
}

require "plugins.autocommands.trouble"

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle quickfix<cr>", { desc = "[T]oggle [T]rouble Quick Fix" })
