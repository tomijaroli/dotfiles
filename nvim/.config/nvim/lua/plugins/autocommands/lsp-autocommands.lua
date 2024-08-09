local lsp_autocommand_callbacks = require "plugins.autocommands.lsp-autocommand-callbacks"

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = lsp_autocommand_callbacks.lsp_on_attach,
})
