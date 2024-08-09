require "plugins.autocommands.lsp-autocommands"
local lsp_autocommand_callbacks = require "plugins.autocommands.lsp-autocommand-callbacks"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

local util = require "lspconfig.util"

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local servers = {
    clangd = {},
    cssls = {},
    gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                },
            },
        },
    },
    html = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    },
    pyright = {},
    tsserver = {},
}

require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
    "stylua",
})
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

local lspconfig = require "lspconfig"
require("mason-lspconfig").setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
        end,
    },
}

lspconfig["sourcekit"].setup {
    capabilities = capabilities,
    on_attach = lsp_autocommand_callbacks.lsp_on_attach,
    root_dir = lspconfig.util.root_pattern(".git", "Package.swift", "compile_commands.json"),
}
