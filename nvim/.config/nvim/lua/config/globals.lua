vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.have_nerd_font = true

-- Plugins still call these; Neovim 0.13 only wraps them in vim.deprecate.
-- Rebind before plugin/*.lua so :checkhealth vim.deprecated stays clean.
vim.F.if_nil = vim.nonnil

function vim.tbl_flatten(t)
  local result = {}
  local function flatten(tbl)
    for i = 1, #tbl do
      local v = tbl[i]
      if type(v) == "table" then
        flatten(v)
      elseif v then
        table.insert(result, v)
      end
    end
  end
  flatten(t)
  return result
end
