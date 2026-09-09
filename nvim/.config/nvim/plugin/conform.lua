require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/stevearc/conform.nvim" },
  }

  local formatters_by_ft = {}
  local formatters = {}
  for file_type, language in pairs(Config.languages) do
    if language.formatters then
      formatters_by_ft[file_type] = language.formatters
    end
    if language.formatter_config and language.formatter_config.name then
      local spec = {
        args = language.formatter_config.args,
        stdin = language.formatter_config.stdin ~= false,
      }
      if language.formatter_config.command then
        spec.command = language.formatter_config.command
      end
      formatters[language.formatter_config.name] = spec
    end
  end

  require("conform").setup {
    notify_on_error = false,
    log_level = vim.log.levels.ERROR,
    formatters_by_ft = formatters_by_ft,
    formatters = formatters,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "never",
      stop_after_first = true,
    },
  }
end)
