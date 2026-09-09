vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
  },
}

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
    pcall(vim.api.nvim_clear_autocmds, { group = "user-lsp-highlight", buffer = event.buf })
    pcall(vim.api.nvim_clear_autocmds, { group = "user-lsp-signature", buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    local buf = event.buf

    -- Conform owns format-on-save once it is installed.
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    if client:supports_method("textDocument/completion", buf) then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, { buffer = buf, desc = "LSP completion" })
    end

    if client:supports_method("textDocument/declaration", buf) then
      vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = buf, desc = "Goto Declaration" })
    end

    if client:supports_method("textDocument/documentHighlight", buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client:supports_method("textDocument/signatureHelp", buf) then
      vim.api.nvim_create_autocmd("CursorHoldI", {
        buffer = buf,
        group = vim.api.nvim_create_augroup("user-lsp-signature", { clear = false }),
        callback = function()
          vim.lsp.buf.signature_help { silent = true }
        end,
      })
    end

    if client:supports_method("textDocument/inlayHint", buf) then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
      end, { buffer = buf, desc = "[T]oggle Inlay [H]ints" })
    end
  end,
})

vim.lsp.enable { "lua_ls", "bashls", "html", "jsonls", "yamlls" }
