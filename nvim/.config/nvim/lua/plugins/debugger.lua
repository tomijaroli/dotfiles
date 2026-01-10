local dap = require "plugins.config.debugger.nvim-dap"
local dap_ui = require "plugins.config.debugger.nvim-dap-ui"
dap_ui.dependencies = dap_ui.dependencies or {}
table.insert(dap_ui.dependencies, dap)

return {
  dap,
  dap_ui,
}
