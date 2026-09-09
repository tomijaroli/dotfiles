local opts = { noremap = true, silent = true }

-- General Editing
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear highlights" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" })
vim.keymap.set("n", "gG", "gg<S-v>G", { desc = "Select all" })
vim.keymap.set("n", "<leader>wt", ":set wrap!<CR>", { desc = "Toggle word wrapping" })

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { desc = "Close current buffer" })

-- Disable arrow keys
vim.keymap.set("n", "<left>", '<cmd>echo "Use h"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j"<CR>')

-- Ctrl + hjkl for moving between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left (default: <C-w>h)" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down (default: <C-w>j)" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up (default: <C-w>k)" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right (default: <C-w>l)" })

-- Diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open local diagnostics list (default: :lopen / :lclose for location list)" }
)
vim.keymap.set(
  "n",
  "<leader>Q",
  vim.diagnostic.setqflist,
  { desc = "Open global diagnostics list (default: :lopen / :lclose for location list)" }
)

-- Registers
vim.keymap.set({ "n", "v", "x" }, "y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "d", '"+d')
vim.keymap.set("n", "x", '"_x', { desc = "Delete without yank" })
vim.keymap.set("n", "c", '"_c', { desc = "Change without yank" })
vim.keymap.set("n", "C", '"_C', { desc = "Change line without yank" })

vim.keymap.set("n", "lg", function()
  vim.cmd "tabnew | terminal lazygit"
  vim.cmd "startinsert"
end, { desc = "Open lazygit" })
