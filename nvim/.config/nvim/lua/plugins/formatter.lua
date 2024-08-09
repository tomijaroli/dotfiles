return {
  {
    "stevearc/conform.nvim",
    config = function()
      require "plugins.config.conform"
    end,
  },
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json" },
  },
}
