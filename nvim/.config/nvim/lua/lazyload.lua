local M = {}

local vim_enter_queue = {}
local override_queue = {}
local very_lazy_queue = {}

local function drain(queue)
  for _, entry in ipairs(queue) do
    if not entry.sync then
      vim.schedule(entry.fn)
    end
  end
  for _, entry in ipairs(queue) do
    if entry.sync then
      entry.fn()
    end
  end
end

local function drain_override()
  if not override_queue then
    return
  end
  for _, entry in ipairs(override_queue) do
    vim.schedule(function()
      local ok, err = pcall(entry.fn)
      if not ok then
        vim.notify((".nvim.lua override error:\n%s"):format(err), vim.log.levels.ERROR)
      end
    end)
  end
  override_queue = nil
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    drain(vim_enter_queue)
    vim_enter_queue = nil
    drain_override()
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    local queue = very_lazy_queue
    very_lazy_queue = nil
    vim.schedule(function()
      for _, fn in ipairs(queue) do
        fn()
      end
    end)
  end,
})

---Run `fn` at most once. Later calls are no-ops.
---@param fn function
---@return function
function M.once(fn)
  local done = false
  return function(...)
    if done then
      return
    end
    done = true
    return fn(...)
  end
end

---Queue a callback for VimEnter. Async via vim.schedule unless opts.sync.
---@param fn function
---@param opts? { sync?: boolean }
function M.on_vim_enter(fn, opts)
  local sync = opts and opts.sync or false
  if vim_enter_queue then
    table.insert(vim_enter_queue, { fn = fn, sync = sync })
  elseif sync then
    fn()
  else
    vim.schedule(fn)
  end
end

---After first UI paint (UIEnter + schedule). Use for UI plugins that are not
---needed to draw the first frame.
---@param fn function
function M.on_very_lazy(fn)
  if very_lazy_queue then
    table.insert(very_lazy_queue, fn)
  else
    vim.schedule(fn)
  end
end

---Queue a callback after all VimEnter plugin setup (exrc / xim overrides).
---@param fn function
function M.on_override(fn)
  if override_queue then
    table.insert(override_queue, { fn = fn })
  else
    vim.schedule(fn)
  end
end

return M
