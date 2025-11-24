local M = {}

local utils = require "plugins.utils.swift-tools"

M.languages = {
  lua = {
    treesitter = "lua",
    lsp = "lua_ls",
    lsp_config = {
      settings = {
        Lua = {
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          diagnostics = { globals = { "vim" } },
        },
      },
    },
    formatters = { "stylua" },
    linters = { "luacheck" },
    linter_config = {
      luacheck = {
        cmd = "luacheck",
        stdin = false,
        args = { "--codes", "--std", "lua54" },
        ignore_exitcode = true,
      },
    },
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  swift = {
    treesitter = "swift",
    lsp = "sourcekit",
    lsp_config = nil,
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
          -- Get the current buffer's filename
          local filename = vim.api.nvim_buf_get_name(0)
          if not filename or filename == "" then
            return { "lint", "--use-stdin", "--reporter", "json" }
          end

          -- Create a context object similar to what conform uses
          local ctx = { filename = filename }
          local extra_args = utils.swiftlint_args_flexible(ctx)

          -- Base args for swiftlint with stdin support
          local base_args = { "lint", "--use-stdin", "--reporter", "json" }

          -- Merge extra args (config) with base args
          for _, arg in ipairs(extra_args) do
            table.insert(base_args, arg)
          end

          return base_args
        end,
      },
    },
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  bash = {
    treesitter = "bash",
    lsp = "bashls",
    lsp_config = nil,
    formatters = { "shfmt" },
    formatter_config = nil,
    linters = { "shellcheck" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  sh = {
    treesitter = "bash",
    lsp = nil,
    lsp_config = nil,
    formatters = { "shfmt" },
    formatter_config = nil,
    linters = { "shellcheck" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  zsh = {
    treesitter = "bash",
    lsp = nil,
    lsp_config = nil,
    formatters = { "shfmt" },
    formatter_config = nil,
    linters = { "shellcheck" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  html = {
    treesitter = "html",
    lsp = "html",
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  json = {
    treesitter = "json",
    lsp = "jsonls",
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  yaml = {
    treesitter = "yaml",
    lsp = "yamlls",
    lsp_config = nil,
    formatters = { "yamlls" },
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  javascript = {
    treesitter = nil,
    lsp = nil,
    lsp_config = nil,
    formatters = { "prettierd", "prettier" },
    formatter_config = nil,
    linters = { "eslint_d" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  typescript = {
    treesitter = nil,
    lsp = nil,
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = { "eslint_d" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  ruby = {
    treesitter = nil,
    lsp = nil,
    lsp_config = nil,
    formatters = { "rubocop" },
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = true,
    treesitter_additional_vim_regex = true,
  },

  markdown = {
    treesitter = "markdown",
    lsp = nil,
    lsp_config = nil,
    formatters = { "prettier" },
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  markdown_inline = {
    treesitter = "markdown_inline",
    lsp = nil,
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  gitignore = {
    treesitter = "gitignore",
    lsp = nil,
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  vim = {
    treesitter = "vim",
    lsp = nil,
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  vimdoc = {
    treesitter = "vimdoc",
    lsp = nil,
    lsp_config = nil,
    formatters = nil,
    formatter_config = nil,
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },
}

return M
