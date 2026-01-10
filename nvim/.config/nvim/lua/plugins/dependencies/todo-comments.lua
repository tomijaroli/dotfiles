local keystore = require "plugins.dependencies.keystore"

local M = {}

M.key = "todo_comments"
M.repository = "folke/todo-comments.nvim"
M.opts = { signs = false }
M.dependencies = { keystore.plenary }

keystore.todo_comments = M.key

return M
