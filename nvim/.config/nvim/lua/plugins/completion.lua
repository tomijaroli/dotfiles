local luasnip = require "plugins.config.completion.luasnip"
local friendly_snippets = require "plugins.config.completion.friendly-snippets"
luasnip.dependencies = luasnip.dependencies or {}
table.insert(luasnip.dependencies, friendly_snippets)

local lspkind = require "plugins.config.completion.lspkind"
local cmp = require "plugins.config.completion.cmp"
cmp.dependencies = cmp.dependencies or {}
table.insert(cmp.dependencies, lspkind)

return {
  cmp,
  luasnip,
  lspkind,
}
