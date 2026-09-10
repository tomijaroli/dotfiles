local lazyload = require "lazyload"

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user-markdown-preview-pack", { clear = true }),
  callback = function(event)
    if event.data.spec.name == "markdown-preview.nvim" and event.data.kind ~= "delete" then
      vim.schedule(function()
        pcall(vim.fn["mkdp#util#install"])
      end)
    end
  end,
})

local setup = lazyload.once(function()
  vim.pack.add({
    { src = "https://github.com/iamcco/markdown-preview.nvim" },
  }, { load = true })

  vim.g.mkdp_combine_preview = 1
  vim.g.mkdp_combine_preview_auto_refresh = 1
end)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-markdown-preview", { clear = true }),
  pattern = "markdown",
  callback = function(event)
    setup()
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", {
      buffer = event.buf,
      desc = "[M]arkdown [P]review",
    })
  end,
})
