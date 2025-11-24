local di = require "plugins.utils.dependency-injection"
local dependencies_registry = require "plugins.dependencies.registry"

local dependencies = {
  dependencies_registry.keys.web_devicons,
}

local lualine = require "plugins.config.ui.lualine"

di.inject_dependencies_by_key(lualine, dependencies, dependencies_registry)

return {
  lualine,
  require "plugins.config.ui.nightfox",
  require "plugins.config.ui.fidget",
}
