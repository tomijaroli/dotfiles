local keystore = require("plugins.dependencies.keystore")

local M = {}

M.key = "plenary"
M.repository = "nvim-lua/plenary.nvim"
M.opts = {}

keystore.plenary = M.key

return M
