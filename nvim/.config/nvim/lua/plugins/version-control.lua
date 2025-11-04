local di = require("plugins.utils.dependency-injection")
local dependencies_registry = require("plugins.dependencies.registry")

local dependencies = {
  dependencies_registry.keys.plenary,
}

local lazygit = require 'plugins.config.version-control.lazygit'

di.inject_dependencies_by_key(lazygit, dependencies, dependencies_registry)

return {
  require 'plugins.config.version-control.gitsigns',
  lazygit,
}
