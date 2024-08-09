return {
    "akinsho/bufferline.nvim",
    config = function()
        local bufferline = require "bufferline"

        bufferline.setup {
            options = {
                mode = "tabs",
                always_show_bufferline = false,
                show_buffer_close_icons = false,
                show_close_icon = false,
                color_icons = true,
            },
            highlights = {
                separator = {
                    fg = "#073642",
                    bg = "NONE",
                },
                separator_selected = {
                    fg = "#073642",
                },
                background = {
                    fg = "#657b83",
                    bg = "NONE",
                },
                buffer_selected = {
                    fg = "#fdf6e3",
                    bold = true,
                },
                fill = {
                    bg = "NONE",
                },
            },
        }
    end,
}
