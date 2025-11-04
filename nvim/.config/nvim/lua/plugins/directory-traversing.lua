local di = require "plugins.utils.dependency-injection"
local dependencies_registry = require "plugins.dependencies.registry"

local dependencies = {
  dependencies_registry.keys.web_devicons,
}

local oil = require "plugins.config.oil"

di.inject_dependencies_by_key(oil, dependencies, dependencies_registry)

return {
  oil,
}
