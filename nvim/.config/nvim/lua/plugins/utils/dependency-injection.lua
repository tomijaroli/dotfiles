local M = {}

local function inject_single(plugin_spec, dep_key, registry, injected)
  injected = injected or {}
  if injected[dep_key] then return end

  local dep = registry[dep_key]
  if not dep then
    local valid_keys = {}
    for k, _ in pairs(registry.keys) do table.insert(valid_keys, k) end
    vim.notify(
      string.format(
        "[Dependency Injection] Invalid key: '%s'. Available keys: %s",
        dep_key,
        table.concat(valid_keys, ", ")
      ),
      vim.log.levels.WARN
    )
    return
  end

  if dep.dependencies then
    for _, sub_key in ipairs(dep.dependencies) do
      inject_single(plugin_spec, sub_key, registry, injected)
    end
  end

  local spec
  local has_opts = dep.opts and next(dep.opts) ~= nil
  local has_event = dep.event ~= nil
  local has_keys = dep.keys ~= nil

  if has_opts or has_event or has_keys then
    spec = { dep.repository }
    if has_opts then spec.opts = dep.opts end
    if has_event then spec.event = dep.event end
    if has_keys then spec.keys = dep.keys end
  else
    spec = dep.repository
  end

  plugin_spec.dependencies = plugin_spec.dependencies or {}
  table.insert(plugin_spec.dependencies, spec)
  injected[dep_key] = true
end

function M.inject_dependencies_by_key(plugin_spec, keys_to_inject, registry)
  local injected = {}
  for _, key in ipairs(keys_to_inject) do
    inject_single(plugin_spec, key, registry, injected)
  end
end

return M

