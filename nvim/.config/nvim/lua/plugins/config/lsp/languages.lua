local M = {}

M.treesitter_languages = {
  "bash",
  "c",
  "gitignore",
  "go",
  "html",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "swift",
  "vim",
  "vimdoc",
  "yaml",
}

M.ts_to_lsp = {
  lua = "lua_ls",
  bash = "bashls",
  html = "html",
  json = "jsonls",
  -- swift = "sourcekit",
  yaml = "yamlls",
  go = "gopls",
  c = "clangd",
}

return M
