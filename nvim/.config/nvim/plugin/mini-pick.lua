require("lazyload").on_vim_enter(function()
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

  local rg_files = {
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
  }

  local function pick_files(opts)
    local source = { name = "Files" }
    if opts and opts.cwd then
      source.cwd = opts.cwd
    end
    MiniPick.builtin.cli({ command = rg_files }, { source = source })
  end

  MiniPick.registry.files = function(local_opts)
    pick_files { cwd = local_opts and local_opts.cwd }
  end

  vim.keymap.set("n", "<leader>ff", pick_files, { desc = "[F]ind [F]iles" })
  vim.keymap.set("n", "<leader>fg", function()
    MiniPick.builtin.grep_live()
  end, { desc = "[F]ind by [G]rep" })
  vim.keymap.set("n", "<leader>fh", function()
    MiniPick.builtin.help()
  end, { desc = "[F]ind [H]elp" })
  vim.keymap.set("n", "<leader>fk", function()
    MiniExtra.pickers.keymaps()
  end, { desc = "[F]ind [K]eymaps" })
  vim.keymap.set("n", "<leader>fs", function()
    MiniPick.registry.registry()
  end, { desc = "[F]ind [S]elect picker" })
  vim.keymap.set("n", "<leader>fd", function()
    MiniExtra.pickers.diagnostic()
  end, { desc = "[F]ind [D]iagnostics" })
  vim.keymap.set("n", "<leader><leader>", function()
    MiniPick.builtin.buffers()
  end, { desc = "[ ] Find existing buffers" })
  vim.keymap.set("n", "<leader>/", function()
    MiniExtra.pickers.buf_lines({ scope = "current" }, {
      window = { config = { winblend = 10 } },
    })
  end, { desc = "[/] Fuzzily search in current buffer" })
  vim.keymap.set("n", "<leader>fn", function()
    pick_files { cwd = vim.fn.stdpath "config" }
  end, { desc = "[F]ind [N]eovim files" })

  local function lsp_picker(scope)
    return function()
      MiniExtra.pickers.lsp { scope = scope }
    end
  end

  vim.keymap.set("n", "grd", lsp_picker "definition", { desc = "Goto Definition" })
  vim.keymap.set("n", "grr", lsp_picker "references", { desc = "Goto References" })
  vim.keymap.set("n", "gri", lsp_picker "implementation", { desc = "Goto Implementation" })
  vim.keymap.set("n", "grt", lsp_picker "type_definition", { desc = "Goto Type Definition" })
  vim.keymap.set("n", "gO", lsp_picker "document_symbol", { desc = "Open Document Symbols" })
  vim.keymap.set("n", "gW", lsp_picker "workspace_symbol_live", { desc = "Open Workspace Symbols" })
end)
