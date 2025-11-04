return {
  "stevearc/conform.nvim",
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = false,
        lsp_fallback_for_disabled = not disable_filetypes[ft],
      }
    end,
    log_level = vim.log.levels.ERROR,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofumpt", "goimports_reviser", "golines" },
      javascript = { { "prettierd", "prettier" } },
      python = { "isort", "black" },
      ruby = { "rubocop" },
      swift = { "swiftformat" },
      yaml = { "yamlls" },
    },
  }
}
