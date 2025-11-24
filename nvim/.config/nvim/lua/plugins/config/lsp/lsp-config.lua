-- Cheatsheet
--
-- Default keymaps:
-- go to var definition: CTRL + ]
-- go to reference tag: CTRL + t
-- format file: =G

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lang_data = require "plugins.config.lsp.languages"

    -- Default options for all LSP servers
    local default_opts = {}

    -- Inject nvim-cmp LSP capabilities
    local cmp_lsp = require "cmp_nvim_lsp"
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_lsp.default_capabilities(capabilities)
    default_opts.capabilities = capabilities

    -- Configure each unique LSP server once
    local seen = {}
    for _, language in pairs(lang_data.languages) do
      local lsp = language.lsp
      if lsp and not seen[lsp] then
        seen[lsp] = true
        local language_opts = language.lsp_config or {}

        if lsp == "sourcekit" then
          if vim.fn.executable "xcrun" == 1 then
            language_opts = vim.tbl_deep_extend(
              "force",
              language_opts,
              { cmd = { vim.trim(vim.fn.system "xcrun -f sourcekit-lsp") } }
            )
          else
            vim.notify("xcrun not found; sourcekit LSP will not be given a cmd", vim.log.levels.WARN)
          end
          vim.cmd [[autocmd CursorHoldI * lua vim.lsp.buf.signature_help()]]
        end

        local opts = vim.tbl_deep_extend("force", default_opts, language_opts)

        local user_on_attach = opts.on_attach
        opts.on_attach = function(client, bufnr)
          -- disable formatting capabilities so external formatters (Conform) win
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          -- call any language-specific on_attach the user configured
          if type(user_on_attach) == "function" then
            user_on_attach(client, bufnr)
          end
        end

        vim.lsp.config(lsp, opts)
        vim.lsp.enable(lsp)
      end
    end

    require("plugins.config.lsp.diagnostics").setup()

    -- LSP Attach autocommand: completion + document highlighting
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        require("plugins.config.lsp.document-highlight").setup(event)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          vim.notify("LSP client not found for buffer " .. event.buf, vim.log.levels.WARN)
          return
        end

        -- now client is guaranteed non-nil
        require("plugins.config.lsp.keymaps").register(event.buf, client, { once = true })
      end,
    })
  end,
}
