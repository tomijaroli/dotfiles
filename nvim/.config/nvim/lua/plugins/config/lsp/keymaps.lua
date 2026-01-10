local M = {}

-- Declarative list of keymaps
-- Each entry can specify:
--   mode          : string or list of modes
--   key           : key sequence
--   action        : function, string, or { "telescope", "builtin_name" }
--   description   : shown in which-key and for readability
--   capability    : optional LSP capability required to register this mapping
local keymap_definitions = {
  {
    mode = "n",
    key = "=G",
    action = "gg=G<C-o>",
    description = "Format file (default keymap)",
  },
  {
    mode = "n",
    key = "grn",
    action = vim.lsp.buf.rename,
    description = "[r]e[n]ame symbol",
    capability = "renameProvider",
  },
  {
    mode = { "n", "x" },
    key = "gra",
    action = vim.lsp.buf.code_action,
    description = "[G]oto Code [A]ction",
    capability = "codeActionProvider",
  },
  {
    mode = "n",
    key = "grr",
    action = { "telescope", "lsp_references" },
    description = "[G]oto [R]eferences",
    capability = "referencesProvider",
  },
  {
    mode = "n",
    key = "gri",
    action = { "telescope", "lsp_implementations" },
    description = "[G]oto [I]mplementation",
    capability = "implementationProvider",
  },
  {
    mode = "n",
    key = "grd",
    action = { "telescope", "lsp_definitions" },
    description = "[G]oto [D]efinition",
    capability = "definitionProvider",
  },
  {
    mode = "n",
    key = "grD",
    action = vim.lsp.buf.declaration,
    description = "[G]oto [D]eclaration",
    capability = "declarationProvider",
  },
  {
    mode = "n",
    key = "gO",
    action = { "telescope", "lsp_document_symbols" },
    description = "Open Document Symbols",
    capability = "documentSymbolProvider",
  },
  {
    mode = "n",
    key = "gW",
    action = { "telescope", "lsp_dynamic_workspace_symbols" },
    description = "Open Workspace Symbols",
    capability = "workspaceSymbolProvider",
  },
  {
    mode = "n",
    key = "grt",
    action = { "telescope", "lsp_type_definitions" },
    description = "[G]oto [T]ype Definition",
    capability = "typeDefinitionProvider",
  },
}

---Resolve a keymap action definition into a callable or command string.
---@param action any
---@return function|string|nil
local function resolve_action(action)
  if type(action) == "function" or type(action) == "string" then
    return action
  end

  if type(action) == "table" and action[1] == "telescope" and action[2] then
    local builtin = require("telescope.builtin")[action[2]]
    if builtin then
      return builtin
    end
    return function()
      vim.notify("Telescope builtin not found: " .. tostring(action[2]), vim.log.levels.WARN)
    end
  end

  return nil
end

---Register all LSP-related keymaps for a specific buffer and client.
---@param buffer number
---@param client vim.lsp.Client
---@param options table|nil { once = boolean }  -- set once per buffer
M.register = function(buffer, client, options)
  options = options or {}

  -- Prevent duplicate registration if requested
  if options.once and vim.b[buffer].lsp_keymaps_registered then
    return
  end

  local function client_supports(capability)
    return not capability or (client.server_capabilities and client.server_capabilities[capability])
  end

  local default_mapping_options = {
    buffer = buffer,
    noremap = true,
    silent = true,
  }

  for _, mapping in ipairs(keymap_definitions) do
    if client_supports(mapping.capability) then
      local action = resolve_action(mapping.action)
      if action then
        local merged_opts = vim.tbl_extend("force", default_mapping_options, mapping.opts or {})
        if mapping.description then
          merged_opts.desc = mapping.description
        end
        vim.keymap.set(mapping.mode, mapping.key, action, merged_opts)
      end
    end
  end

  if options.once then
    vim.b[buffer].lsp_keymaps_registered = true
  end
end

return M
