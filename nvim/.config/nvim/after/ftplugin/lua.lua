vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2

vim.keymap.set("n", "<leader>o", "<CMD>update<CR> :source<CR>", { buffer = true, desc = "Save and reload current file" })
vim.keymap.set("n", "<leader><leader>s", "<CMD>source %<CR>", { buffer = true, desc = "Execute current file" })
vim.keymap.set("n", "<leader>s", "<CMD>.lua<CR>", { buffer = true, desc = "Execute current line" })
vim.keymap.set("v", "<leader>s", "<CMD>lua<CR>", { buffer = true, desc = "Execute current line" })
