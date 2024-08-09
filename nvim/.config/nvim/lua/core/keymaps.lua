local opts = { noremap = true }

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear highlights", silent = true })

-- Diagnostics vim.keymap.sets
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move focus to the upper window" })

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { silent = true, desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { silent = true, desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<Cmd>BufferLineCycleNext<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Go to previous tab" })

-- Disable updating register for x and c
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

vim.keymap.set("n", "gG", "gg<S-v>G", { desc = "Select all" })

-- Editing
vim.keymap.set("n", "<leader>wt", ":set wrap!<CR>", { desc = "Toggle word wrapping" })

vim.keymap.set("i", "jk", "<ESC>") -- quick exit to normal mode

-- vim-maximizer
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Zoom to current window" })

-- WhichKey
vim.keymap.set("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
