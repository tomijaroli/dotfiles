local function setTransparency()
  vim.cmd [[ highlight Normal ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight NormalNC ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight NormalSB ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight NoText ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE ]]
  vim.cmd [[ highlight EndOfBuffer ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight EndOfFile ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight LineNr guibg=none ctermbg=none ]]
  vim.cmd [[ highlight Folded guibg=none ctermbg=none ]]
  vim.cmd [[ highlight SpecialKey guibg=NONE ctermbg=NONE ]]
  vim.cmd [[ highlight VertSplit guibg=NONE ctermbg=NONE ]]
  vim.cmd [[ highlight SignColumn guibg=NONE ctermbg=NONE ]]
  vim.cmd [[ highlight StatusLine ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight LuaLine ctermbg=NONE guibg=NONE ]]
  vim.cmd [[ highlight NvimTreeNormal guibg=NONE ctermbg=NONE ]]
  vim.cmd [[ highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE ]]
end

local function clearBackgrounds()
  setTransparency()

  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = { "*" },
    callback = function()
      setTransparency()
    end,
  })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    if vim.g.user_enable_transparent_background then
      clearBackgrounds()
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
