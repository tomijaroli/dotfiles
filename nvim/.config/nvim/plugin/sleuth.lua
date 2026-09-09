vim.api.nvim_create_autocmd("BufReadPre", {
  group = vim.api.nvim_create_augroup("user-sleuth", { clear = true }),
  once = true,
  callback = function()
    vim.pack.add({
      { src = "https://github.com/tpope/vim-sleuth" },
    }, { load = true })
  end,
})
