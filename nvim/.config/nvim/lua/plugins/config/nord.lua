M = {}

M.repository = "gbprod/nord.nvim"
M.name = "nord"
M.priority = 1000
M.lazy = false

local styles

if vim.g.user_enable_transparent_background then
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  }
end

M.opts = {
  transparent_background = vim.g.user_enable_transparent_background,
  styles = styles,
  integrations = {
    cmp = true,
    gitsigns = true,
    indent_blankline = {
      enabled = false,
      scope_color = "sapphire",
      colored_indent_levels = false,
    },
    mason = true,
    native_lsp = { enabled = true },
    notify = true,
    neotree = true,
    symbols_outline = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
  },
  dim_inactive = {
    enabled = false,
    shade = "light",
    percentage = 0.9,
  },
  custom_highlights = function(colors)
    local searchActive = { bg = colors.red, fg = "#181825" }
    local searchInactive = { bg = colors.peach, fg = "#000000" }

    return {
      CursorLineNr = { fg = colors.flamingo },
      Search = searchInactive,
      IncSearch = searchActive,
      EndOfBuffer = { fg = colors.flamingo },
      WinSeparator = { fg = colors.surface0, bg = colors.surface0 },
    }
  end,
}

return M
