local di = require "plugins.utils.dependency-injection"
local dependencies_registry = require "plugins.dependencies.registry"

local dependencies = {
  dependencies_registry.keys.web_devicons,
}

local lspsaga = require "plugins.config.lsp.lspsaga"

di.inject_dependencies_by_key(lspsaga, dependencies, dependencies_registry)

return {
  require "plugins.config.lsp.mason",
  require "plugins.config.lsp.mason-lspconfig",
  require "plugins.config.lsp.mason-tool-installer",
  require "plugins.config.lsp.lsp-config",
  lspsaga,
  require "plugins.config.lsp.lsp-signature",
}
