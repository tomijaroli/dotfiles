local luasnip = require "plugins.config.completion.luasnip"
local friendly_snippets = require "plugins.config.completion.friendly-snippets"

luasnip.dependencies = luasnip.dependencies or {}

table.insert(luasnip.dependencies, friendly_snippets)

return {
  require "plugins.config.completion.cmp",
  luasnip,
  require "plugins.config.completion.lspkind",
}
