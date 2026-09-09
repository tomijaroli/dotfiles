local lazyload = require "lazyload"

local setup = lazyload.once(function()
  vim.pack.add {
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvim-mini/mini.extra" },
  }

  local MiniPick = require "mini.pick"
  local MiniExtra = require "mini.extra"
  MiniPick.setup()
  MiniExtra.setup()

  MiniPick.registry.registry = function()
    local names = vim.tbl_keys(MiniPick.registry)
    table.sort(names)
    local chosen = MiniPick.start {
      source = {
        name = "Pickers",
        items = names,
        choose = function() end,
      },
    }
    if chosen == nil then
      return
    end
    return MiniPick.registry[chosen]()
  end

  MiniPick.registry.files = function(local_opts)
    local source = { name = "Files" }
    if local_opts and local_opts.cwd then
      source.cwd = local_opts.cwd
    end
    MiniPick.builtin.cli({
      command = {
        "rg",
        "--files",
        "--hidden",
        "--color=never",
        "--glob",
        "!.git/",
        "--glob",
        "!node_modules/",
        "--glob",
        "!.venv/",
      },
    }, { source = source })
  end
end)

Config.ensure_picker = setup

local function pick_files(opts)
  setup()
  require("mini.pick").registry.files { cwd = opts and opts.cwd }
end

local function lsp_picker(scope)
  return function()
    setup()
    require("mini.extra").pickers.lsp { scope = scope }
  end
end

vim.keymap.set("n", "<leader>ff", pick_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", function()
  setup()
  require("mini.pick").builtin.grep_live()
end, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fh", function()
  setup()
  require("mini.pick").builtin.help()
end, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", function()
  setup()
  require("mini.extra").pickers.keymaps()
end, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fs", function()
  setup()
  require("mini.pick").registry.registry()
end, { desc = "[F]ind [S]elect picker" })
vim.keymap.set("n", "<leader>fd", function()
  setup()
  require("mini.extra").pickers.diagnostic()
end, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader><leader>", function()
  setup()
  require("mini.pick").builtin.buffers()
end, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  setup()
  require("mini.extra").pickers.buf_lines({ scope = "current" }, {
    window = { config = { winblend = 10 } },
  })
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>fn", function()
  pick_files { cwd = vim.fn.stdpath "config" }
end, { desc = "[F]ind [N]eovim files" })

vim.keymap.set("n", "grd", lsp_picker "definition", { desc = "Goto Definition" })
vim.keymap.set("n", "grr", lsp_picker "references", { desc = "Goto References" })
vim.keymap.set("n", "gri", lsp_picker "implementation", { desc = "Goto Implementation" })
vim.keymap.set("n", "grt", lsp_picker "type_definition", { desc = "Goto Type Definition" })
vim.keymap.set("n", "gO", lsp_picker "document_symbol", { desc = "Open Document Symbols" })
vim.keymap.set("n", "gW", lsp_picker "workspace_symbol_live", { desc = "Open Workspace Symbols" })
