return {
    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            log_level = vim.log.levels.ERROR,
            -- TODO: fix ruby formatting
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofumpt", "goimports_reviser", "golines" },
                javascript = { { "prettierd", "prettier" } },
                python = { "isort", "black" },
                ruby = { "rubocop" },
                swift = { "swiftformat" },
                yaml = { "yamlls" },
            },
        },
    },
    {
        "gennaro-tedesco/nvim-jqx",
        ft = { "json" },
    },
}
