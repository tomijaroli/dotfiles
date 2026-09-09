local nvim_config = vim.fs.normalize(vim.fn.expand "~/.config/nvim")
if not vim.uv.fs_stat(nvim_config) then
  error("Base nvim config not found at " .. nvim_config)
end

vim.opt.runtimepath:prepend(nvim_config)

local nvim_after = vim.fs.joinpath(nvim_config, "after")
local xim_after = vim.fs.joinpath(vim.fs.normalize(vim.fn.stdpath "config"), "after")
local rtp = vim.opt.runtimepath:get()
local new_rtp = {}
local inserted = false
for _, path in ipairs(rtp) do
  if vim.fs.normalize(path) == xim_after then
    table.insert(new_rtp, nvim_after)
    inserted = true
  end
  table.insert(new_rtp, path)
end
if not inserted then
  table.insert(new_rtp, nvim_after)
end
vim.opt.runtimepath = new_rtp

dofile(vim.fs.joinpath(nvim_config, "init.lua"))
require "ios.languages"
