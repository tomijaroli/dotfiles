require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  }

  local filetypes = { "css", "html", "javascript" }
  require("colorizer").setup(filetypes)

  local wanted = {}
  for _, file_type in ipairs(filetypes) do
    wanted[file_type] = true
  end
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if wanted[vim.bo[buf].filetype] then
      require("colorizer").attach_to_buffer(buf)
    end
  end
end)
