local di = require "plugins.utils.dependency-injection"
local dependencies_registry = require "plugins.dependencies.registry"

local dependencies = {
  dependencies_registry.keys.web_devicons,
}

local bufferline = require "plugins.config.ui.bufferline"
local lualine = require "plugins.config.ui.lualine"

di.inject_dependencies_by_key(bufferline, dependencies, dependencies_registry)
di.inject_dependencies_by_key(lualine, dependencies, dependencies_registry)

return {
  bufferline,
  lualine,
  require "plugins.config.ui.tokyonight",
}
