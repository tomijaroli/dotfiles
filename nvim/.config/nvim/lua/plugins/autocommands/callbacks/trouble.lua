M = {}

M.on_xcodebuild_finished = function(event)
  if event.data.cancelled then
    return
  end

  if event.data.success then
    require("trouble").close()
  elseif not event.data.failedCount or event.data.failedCount > 0 then
    if next(vim.fn.getqflist()) then
      require("trouble").open { focus = false }
    else
      require("trouble").close()
    end

    require("trouble").refresh()
  end
end

return M
