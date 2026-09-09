require("lazyload").on_vim_enter(function()
  vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("user-telescope-fzf-pack", { clear = true }),
    callback = function(event)
      if event.data.spec.name == "telescope-fzf-native.nvim" and event.data.kind ~= "delete" then
        vim.system({ "make" }, { cwd = event.data.path, text = true }):wait()
      end
    end,
  })

  vim.pack.add {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  }

  local telescope = require "telescope"
  telescope.setup {
    defaults = {
      path_display = { "smart" },
      file_ignore_patterns = { "node_modules", ".git", ".venv" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
    },
    extensions = {
      fzf = {},
      ["ui-select"] = {},
    },
  }
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "ui-select")

  local builtin = require "telescope.builtin"
  vim.keymap.set("n", "<leader>ff", function()
    builtin.find_files { hidden = true }
  end, { desc = "[F]ind [F]iles" })
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
  vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
  vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[F]ind [S]elect Telescope" })
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
  vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
  vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find {
      winblend = 10,
      previewer = false,
    }
  end, { desc = "[/] Fuzzily search in current buffer" })
  vim.keymap.set("n", "<leader>fn", function()
    builtin.find_files { cwd = vim.fn.stdpath "config" }
  end, { desc = "[F]ind [N]eovim files" })

  vim.keymap.set("n", "grd", builtin.lsp_definitions, { desc = "Goto Definition" })
  vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Goto References" })
  vim.keymap.set("n", "gri", builtin.lsp_implementations, { desc = "Goto Implementation" })
  vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { desc = "Goto Type Definition" })
  vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { desc = "Open Document Symbols" })
  vim.keymap.set("n", "gW", builtin.lsp_dynamic_workspace_symbols, { desc = "Open Workspace Symbols" })
end)
