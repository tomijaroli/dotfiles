return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  build = "make install_jsregexp",
  dependencies = {},
  config = function()
    local ok, luasnip = pcall(require, "luasnip")
    if not ok then
      vim.notify("LuaSnip not available", vim.log.levels.WARN)
      return
    end

    luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = false,
    }

    pcall(function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end)

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      end
    end, { silent = true, desc = "LuaSnip jump forward" })

    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "LuaSnip jump backward" })
  end,
}
