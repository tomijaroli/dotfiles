local utils = require "swift-tools"

Config.languages.swift = {
  treesitter = "swift",
  formatters = { "swiftformat" },
  formatter_config = {
    name = "swiftformat",
    command = "swiftformat",
    args = utils.swiftformat_args_flexible,
    stdin = true,
  },
  linters = { "swiftlint" },
  linter_config = {
    swiftlint = {
      args = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if not filename or filename == "" then
          return { "lint", "--use-stdin", "--reporter", "json" }
        end

        local extra_args = utils.swiftlint_args_flexible { filename = filename }
        local base_args = { "lint", "--use-stdin", "--reporter", "json" }
        for _, arg in ipairs(extra_args) do
          table.insert(base_args, arg)
        end
        return base_args
      end,
    },
  },
}
