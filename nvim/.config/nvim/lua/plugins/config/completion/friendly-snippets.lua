return {
  "rafamadriz/friendly-snippets",
  config = function()
    local ok, ls_loader = pcall(require, "luasnip.loaders.from_vscode")
    if ok and ls_loader then
      ls_loader.lazy_load()
    end
  end,
}
