return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", desc = "[F]ind [F]iles" },
    { "<leader>fg", "<cmd>Telescope live_grep hidden=true<CR>", desc = "[F]ind by [G]rep" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "[F]ind [H]elp" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "[F]ind [K]eymaps" },
    { "<leader>fs", "<cmd>Telescope builtin<CR>", desc = "[F]ind [S]elect Telescope" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "[F]ind [D]iagnostics" },
    { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "[F]ind [T]odo Comments" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find {
          winblend = 10,
          previewer = false,
        }
      end,
      desc = "[/] Fuzzily search in current buffer",
    },
    {
      "<leader>fn",
      function()
        require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
      end,
      desc = "[F]ind [N]eovim files",
    },
  },
  opts = {
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
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
  end,
}
