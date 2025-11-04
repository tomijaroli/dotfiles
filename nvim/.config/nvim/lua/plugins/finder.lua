local di = require "plugins.utils.dependency-injection"
local dependencies_registry = require "plugins.dependencies.registry"

local dependencies = {
  dependencies_registry.keys.plenary,
  dependencies_registry.keys.web_devicons,
  dependencies_registry.keys.todo_comments,
}

local telescope = require "plugins.config.finder.telescope"
local fzf_native = require "plugins.config.finder.telescope-fzf-native"
local ui_select = require "plugins.config.finder.telescope-ui-select"

telescope.dependencies = telescope.dependencies or {}

table.insert(telescope.dependencies, fzf_native)
table.insert(telescope.dependencies, ui_select)

di.inject_dependencies_by_key(telescope, dependencies, dependencies_registry)

return {
  telescope,
}
