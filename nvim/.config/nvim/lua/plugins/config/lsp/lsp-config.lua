-- lua/plugins/config/lsp/lsp-config.lua

-- Cheatsheet
--
-- go to var definition: CTRL + ]
-- go to reference tag: CTRL + t
-- go to references: grr
-- go to implementation: gri
-- symbols: gO
-- rename: grn
-- format file: =G

return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.keymap.set('n', '=G', 'gg=G<C-o>', { desc = "Format file - default keymap" })

        local lang_data = require("plugins.config.lsp.languages")

        -- Build list of servers for Mason
        local mason_servers = {}
        for _, lang in ipairs(lang_data.treesitter_languages) do
            local lsp = lang_data.ts_to_lsp[lang]
            if lsp then
                table.insert(mason_servers, lsp)
            end
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = mason_servers,
            automatic_installation = false,
        })

        -- Default options for all LSP servers
        local default_opts = {}

        -- Server-specific overrides
        local server_opts = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        diagnostics = { globals = { "vim" } },
                    },
                },
            },
            -- sourcekit = {
            --     cmd = { "sourcekit-lsp" },
            --     root_dir = vim.fs.dirname(
            --         vim.fs.find({ ".git", "Package.swift", "compile_commands.json" }, { upward = true })[1]
            --     ),
            -- },
        }

        -- Configure LSP servers based on Treesitter languages
        for _, lang in ipairs(lang_data.treesitter_languages) do
            local lsp = lang_data.ts_to_lsp[lang]
            if lsp then
                local opts = vim.tbl_deep_extend("force", default_opts, server_opts[lsp] or {})
                vim.lsp.config(lsp, opts)
            end
        end

        -- Autoformat on save
        local augroup = vim.api.nvim_create_augroup("LspAutoFormatting", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            callback = function(event)
                local bufnr = event.buf
                local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

                local formatted = false

                for _, client in ipairs(clients) do
                    if client.supports_method("textDocument/formatting") then
                        vim.lsp.buf.format({
                            bufnr = bufnr,
                            async = true,
                            filter = function(c) return c.id == client.id end,
                        })
                        formatted = true
                        break
                    end
                end

                -- If no LSP supports formatting, fallback to CLI formatter
                if not formatted then
                    local ft = vim.bo[bufnr].filetype
                    if ft == "lua" then
                        vim.cmd("silent! !stylua " .. vim.fn.expand("%"))
                    elseif ft == "swift" then
                        vim.cmd("silent! !swiftformat " .. vim.fn.expand("%"))
                    end
                end
            end,
        })

        -- LSP Attach autocommand: completion + document highlighting
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client:supports_method('textDocument/completion') then
                    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
                end

                if client.server_capabilities.documentHighlightProvider then
                    require("plugins.config.lsp.document-highlight").setup(ev.buf)
                end
            end,
        })
    end
}
