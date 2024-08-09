local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })

-- hide ~ in DAPUI
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  pattern = "DAP*",
  callback = function()
    vim.wo.fillchars = "eob: "
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  pattern = "\\[dap\\-repl\\]",
  callback = function()
    vim.wo.fillchars = "eob: "
  end,
})
