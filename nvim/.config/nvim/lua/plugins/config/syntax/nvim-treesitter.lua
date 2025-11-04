local lang_data = require("plugins.config.lsp.languages")

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    ensure_installed = lang_data.treesitter_languages,
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
    autotag = { enable = true },
  },
}
