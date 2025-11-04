local config = require "plugins.config.oil"

return {
  config.repository,
  opts = config.opts,
  keys = config.keys,
  dependencies = config.dependencies,
  lazy = config.lazy,
}
