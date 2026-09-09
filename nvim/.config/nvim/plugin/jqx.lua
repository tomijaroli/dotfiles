vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-jqx", { clear = true }),
  pattern = { "json", "yaml" },
  once = true,
  callback = function()
    vim.pack.add({
      { src = "https://github.com/gennaro-tedesco/nvim-jqx" },
    }, { load = true })
  end,
})
