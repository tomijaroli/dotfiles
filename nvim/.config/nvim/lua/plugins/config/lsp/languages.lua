local M = {}

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
    linters = { "swiftlint" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  bash = {
    treesitter = "bash",
    lsp = "bashls",
    lsp_config = nil,
    formatters = { "shfmt" },
    linters = { "shellcheck" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  sh = {
    treesitter = "bash", -- uses bash parser
    lsp = nil,
    lsp_config = nil,
    formatters = { "shfmt" },
    linters = { "shellcheck" },
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },

  zsh = {
    treesitter = "bash", -- uses bash parser
    lsp = nil,
    lsp_config = nil,
    formatters = { "shfmt" },
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
    formatters = { { "prettierd", "prettier" } },
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
    linters = nil,
    linter_config = nil,
    format_disabled = nil,
    treesitter_indent_disabled = nil,
    treesitter_additional_vim_regex = nil,
  },
}

return M
