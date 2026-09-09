-- xcodebuild.nvim only ships Telescope / Snacks / fzf-lua pickers.
-- Implement its PickerIntegration with mini.pick so xim can drop Telescope.
local MiniPick = require "mini.pick"
local pickers_utils = require "xcodebuild.ui.pickers_utils"

local M = {
  start_progress = function() end,
  stop_progress = function() end,
  close = function() end,
  update_results = function() end,
  show = function() end,
  show_multiselect = function() end,
}

local active = {
  title = nil,
  items = {},
  opts = {},
  callback = nil,
  multiselect = false,
}

local function display_name(entry)
  if type(entry) == "table" and entry.id then
    return pickers_utils.get_destination_name(entry)
  end
  return tostring(entry)
end

local function to_items(entries)
  local items = {}
  for index, entry in ipairs(entries) do
    items[index] = {
      text = display_name(entry),
      value = entry,
      index = index,
    }
  end
  return items
end

local function stop_picker()
  if MiniPick.is_picker_active() then
    MiniPick.stop()
  end
end

function M.start_progress() end

function M.stop_progress() end

function M.close()
  stop_picker()
end

function M.update_results(results)
  active.items = results or {}
  if MiniPick.is_picker_active() then
    MiniPick.set_picker_items(to_items(active.items))
    return
  end
  if active.multiselect then
    M.show_multiselect(active.title, active.items, active.callback)
  else
    M.show(active.title, active.items, active.opts, active.callback)
  end
end

function M.show(title, items, opts, callback)
  opts = opts or {}
  active.title = title
  active.items = items or {}
  active.opts = opts
  active.callback = callback
  active.multiselect = false

  MiniPick.start {
    source = {
      name = title,
      items = to_items(active.items),
      choose = function(item)
        if not item or not callback then
          return
        end
        local keep_open = not opts.close_on_select or item.value == "[Reload Schemes]"
        vim.schedule(function()
          callback({ index = item.index, value = item.value }, item.index)
        end)
        return keep_open
      end,
    },
  }
end

function M.show_multiselect(title, items, callback)
  active.title = title
  active.items = items or {}
  active.opts = {}
  active.callback = callback
  active.multiselect = true

  MiniPick.start {
    source = {
      name = title,
      items = to_items(active.items),
      choose = function(item)
        if not callback or not item then
          return
        end
        vim.schedule(function()
          callback { item.value }
        end)
      end,
      choose_marked = function(marked)
        if not callback then
          return
        end
        local values = {}
        for _, item in ipairs(marked or {}) do
          table.insert(values, item.value)
        end
        if #values == 0 then
          return
        end
        vim.schedule(function()
          callback(values)
        end)
      end,
    },
  }
end

return M
