local M = {}

M.setup = function()
  vim.diagnostic.config {
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }

  local signs = {
    Error = "",
    Warn = "",
    Hint = "󰠠",
    Info = "",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
