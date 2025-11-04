local plenary = require("plugins.dependencies.plenary")
local web_devicons = require("plugins.dependencies.web-devicons")
local todo_comments = require("plugins.dependencies.todo-comments")

local M = {}

M[plenary.key] = plenary
M[web_devicons.key] = web_devicons
M[todo_comments.key] = todo_comments

M.keys = require("plugins.dependencies.keystore")

return M

