-- nvim-treesitter main must register parsers on runtimepath at startup.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("user-treesitter-pack", { clear = true }),
  callback = function(event)
    if event.data.spec.name == "nvim-treesitter" and event.data.kind ~= "delete" then
      vim.schedule(function()
        pcall(vim.cmd.TSUpdate)
      end)
    end
  end,
})

vim.pack.add {
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}

vim.schedule(function()
  require("nvim-treesitter").install(Config.treesitter_parsers())
end)

local indent_disabled = {}
for file_type, language in pairs(Config.languages) do
  if language.treesitter_indent_disabled then
    indent_disabled[file_type] = true
  end
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
  callback = function(event)
    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end

    pcall(vim.treesitter.start, event.buf)

    if not indent_disabled[event.match] then
      vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
