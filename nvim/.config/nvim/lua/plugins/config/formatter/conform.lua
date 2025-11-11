local lang_data = require "plugins.config.lsp.languages"

local formatters_by_ft = {}
local disable_filetypes = {}
for file_type, language in pairs(lang_data.languages) do
  if language.formatters then
    formatters_by_ft[file_type] = language.formatters
  end

  if language.format_disabled then
    disable_filetypes[file_type] = true
  end
end

return {
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local file_type = vim.bo[bufnr].filetype
      return {
        timeout_ms = 500,
        lsp_fallback = false,
        lsp_fallback_for_disabled = not disable_filetypes[file_type],
      }
    end,
    log_level = vim.log.levels.ERROR,
    formatters_by_ft = formatters_by_ft,
  },
}
