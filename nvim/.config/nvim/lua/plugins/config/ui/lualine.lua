return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "nordfox",
      icons_enabled = true,
      globalstatus = true,
      section_separators = "",
      component_separators = "",
      disabled_filetypes = { statusline = { "dashboard", "starter" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = {
            modified = "●",
            readonly = "",
          },
        },
      },
      lualine_x = {
        "encoding",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = { "quickfix" },
  },
}
