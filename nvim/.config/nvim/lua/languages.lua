-- Per-filetype treesitter / format / lint. LSP configs live in lsp/*.lua.
-- xim (and other overlays) can add entries to Config.languages before VimEnter.

Config.languages = vim.tbl_extend("force", Config.languages, {
  lua = {
    treesitter = "lua",
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
  },
  bash = {
    treesitter = "bash",
    formatters = { "shfmt" },
    linters = { "shellcheck" },
  },
  sh = {
    treesitter = "bash",
    formatters = { "shfmt" },
    linters = { "shellcheck" },
  },
  zsh = {
    treesitter = "bash",
    formatters = { "shfmt" },
    linters = { "shellcheck" },
  },
  html = {
    treesitter = "html",
  },
  json = {
    treesitter = "json",
  },
  yaml = {
    treesitter = "yaml",
  },
  javascript = {
    formatters = { "prettierd", "prettier" },
    linters = { "eslint_d" },
  },
  typescript = {
    linters = { "eslint_d" },
  },
  ruby = {
    formatters = { "rubocop" },
    treesitter_indent_disabled = true,
  },
  markdown = {
    treesitter = "markdown",
    formatters = { "prettier" },
  },
  markdown_inline = {
    treesitter = "markdown_inline",
  },
  gitignore = {
    treesitter = "gitignore",
  },
  vim = {
    treesitter = "vim",
  },
  vimdoc = {
    treesitter = "vimdoc",
  },
})

function Config.treesitter_parsers()
  local seen, parsers = {}, {}
  for _, language in pairs(Config.languages) do
    if language.treesitter and not seen[language.treesitter] then
      seen[language.treesitter] = true
      table.insert(parsers, language.treesitter)
    end
  end
  return parsers
end
