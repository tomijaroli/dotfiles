require "plugins.autocommands.oil"

local oil = require "oil"

oil.setup {
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
