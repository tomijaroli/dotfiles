vim.keymap.set("n", "<leader>o", "<CMD>update<CR> :source<CR>", { buffer = true, desc = "Save and reload current file" })
vim.keymap.set("n", "<leader><leader>s", "<CMD>source %<CR>", { buffer = true, desc = "Execute current file" })
