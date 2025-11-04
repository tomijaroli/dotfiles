return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers",
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
      diagnostics = false,
      offsets = {
        {
          filetype = "oil",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
    highlights = {
      fill = { link = "Normal" },
      background = { link = "Normal" },
      buffer_selected = { link = "Normal" },
      buffer_visible = { link = "Normal" },
      separator = { link = "Normal" },
      separator_visible = { link = "Normal" },
      separator_selected = { link = "Normal" },
    },
  },
}

