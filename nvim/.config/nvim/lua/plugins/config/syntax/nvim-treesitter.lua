local lang_data = require "plugins.config.lsp.languages"

local treesitter_parsers = {}
local treesitter_seen = {}
local additional_vim_regex_file_types = {}
local indent_disabled_file_types = {}

for file_type, language in pairs(lang_data.languages) do
  if language.treesitter and not treesitter_seen[language.treesitter] then
    treesitter_seen[language.treesitter] = true
    table.insert(treesitter_parsers, language.treesitter)
  end

  if language.treesitter_additional_vim_regex then
    table.insert(additional_vim_regex_file_types, file_type)
  end

  if language.treesitter_indent_disabled then
    table.insert(indent_disabled_file_types, file_type)
  end
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    ensure_installed = treesitter_parsers,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = additional_vim_regex_file_types,
    },
    indent = { enable = true, disable = indent_disabled_file_types },
    autotag = { enable = true },
  },
}
