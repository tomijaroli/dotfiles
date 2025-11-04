local tools = require("plugins.config.lsp.tools").tools

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = {
    ensure_installed = tools,
    auto_update = true,
    run_on_start = true,
  },
}
