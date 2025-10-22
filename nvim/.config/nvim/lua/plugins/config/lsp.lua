require "plugins.autocommands.lsp"
local lsp_autocommand_callbacks = require "plugins.autocommands.callbacks.lsp"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.diagnostic.config {
  signs = {
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
    values = {
      Error = "",
      Warn = "",
      Hint = "󰠠",
      Info = "",
    },
  },
}

local servers = {
  clangd = {},
  cssls = {},
  html = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { globals = { "vim" } },
      },
    },
  },
  pyright = {},
  ts_ls = {},
  yamlls = {},
}

require("mason").setup()
local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, { "stylua" })
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

local function start_server(name, opts)
  vim.lsp.start(vim.tbl_deep_extend("force", {
    name = name,
    cmd = { name },
    capabilities = capabilities,
    on_attach = lsp_autocommand_callbacks.lsp_on_attach,
    root_dir = vim.fs.dirname(
      vim.fs.find({ ".git", "package.json", "setup.py", "Makefile", "tsconfig.json" }, { upward = true })[1]
    ),
  }, opts or {}))
end

require("mason-lspconfig").setup {
  handlers = {
    function(server_name)
      start_server(server_name, servers[server_name])
    end,
  },
}

start_server("sourcekit", {
  cmd = { "sourcekit-lsp" },
  root_dir = vim.fs.dirname(vim.fs.find({ ".git", "Package.swift", "compile_commands.json" }, { upward = true })[1]),
})
