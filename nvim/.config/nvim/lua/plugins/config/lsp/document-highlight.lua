local M = {}

M.setup = function(bufnr)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

return M
