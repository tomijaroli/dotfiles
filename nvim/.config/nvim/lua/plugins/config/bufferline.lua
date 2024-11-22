require("bufferline").setup {
  options = {
    mode = "buffer",
    themeable = "true",
    numbers = "none",
    path_components = 1,
    max_name_length = 30,
    max_prefix_length = 30,
    tab_size = 21,
    diagnostics = false,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { "│", "│" },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    show_tab_indicators = false,
    indicator = {
      style = "none",
    },
    minimum_padding = 1,
    maximum_padding = 5,
    maximum_length = 15,
    sort_by = "insert_at_end",
  },
  highlights = {
    separator = {
      fg = "#434C5E",
      bg = "NONE",
    },
    background = {
      fg = "NONE",
      bg = "NONE",
    },
    buffer_selected = {
      fg = "NONE",
      bold = true,
      italic = false,
    },
    fill = {
      bg = "NONE",
    },
  },
}
