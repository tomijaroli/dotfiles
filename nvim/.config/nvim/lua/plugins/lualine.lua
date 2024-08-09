return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require "lualine"

        local function xcodebuild_device()
            if vim.g.xcodebuild_platform == "macOS" then
                return " macOS"
            end

            if vim.g.xcodebuild_os then
                return " " .. vim.g.xcodebuild_device_name .. " (" .. vim.g.xcodebuild_os .. ")"
            end

            return " " .. vim.g.xcodebuild_device_name
        end

        lualine.setup {
            options = {
                icons_enabled = true,
                theme = "auto",
                section_separators = "",
                disabled_filetypes = { "quickfix", "prompt" },
                globalstatus = true,
                symbols = {
                    alternate_file = "#",
                    directory = "",
                    readonly = "",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
            },
            sections = {
                -- lualine_a = { "mode" },
                lualine_a = { "filename" },
                lualine_b = {
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = { error = " ", warn = " ", info = " ", hint = " " },
                    },
                    "encoding",
                    "filetype",
                },
                lualine_c = {
                    { "diff" },
                    {
                        "searchcount",
                        maxcount = 999,
                        timeout = 500,
                    },
                },
                lualine_x = {
                    {
                        "' ' .. vim.g.xcodebuild_last_status",
                        color = { fg = "#a6e3a1" },
                    },
                    {
                        "'󰙨 ' .. vim.g.xcodebuild_test_plan",
                        color = { fg = "#a6e3a1", bg = "#161622" },
                    },
                    { xcodebuild_device, color = { fg = "#f9e2af", bg = "#161622" } },
                },
                lualine_y = { "branch" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        "filename",
                        file_status = true,
                        path = 1,
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {
                "fugitive",
                "nvim-dap-ui",
                "quickfix",
                "trouble",
                "lazy",
                "mason",
            },
        }
    end,
}
