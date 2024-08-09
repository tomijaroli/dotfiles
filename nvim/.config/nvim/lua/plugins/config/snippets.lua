local luasnip = require "luasnip"

vim.snippet.expand = luasnip.lsp_expand

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return luasnip.expand_or_jumpable()
  else
    return luasnip.jumpable(filter.direction)
  end
end

---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
  if direction == 1 then
    if luasnip.expandable() then
      return luasnip.expand_or_jump()
    else
      return luasnip.jumpable(1) and luasnip.jump(1)
    end
  else
    return luasnip.jumpable(-1) and luasnip.jump(-1)
  end
end

vim.snippet.stop = luasnip.unlink_current

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  override_builtin = true,
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
end, { silent = true })
