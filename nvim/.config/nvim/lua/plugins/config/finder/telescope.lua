return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  cmd = "Telescope",
  keys = {
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "[S]earch [K]eymaps" },
    { "<leader>sf", "<cmd>Telescope find_files<CR>", desc = "[S]earch [F]iles" },
    { "<leader>sF", "<cmd>Telescope find_files hidden=true<CR>", desc = "[S]earch [F]iles including hidden" },
    { "<leader>ss", "<cmd>Telescope builtin<CR>", desc = "[S]earch [S]elect Telescope" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "[S]earch by [G]rep" },
    { "<leader>sd", "<cmd>Telescope diagnostics<CR>", desc = "[S]earch [D]iagnostics" },
    { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "[ ] Find existing buffers" },
    { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "[S]earch [T]odo Comments" },
    { "<leader>/", function()
        require("telescope.builtin").current_buffer_fuzzy_find({
          winblend = 10,
          previewer = false,
        })
      end, desc = "[/] Fuzzily search in current buffer" },
    { "<leader>s/", function()
        require("telescope.builtin").live_grep { grep_open_files = true, prompt_title = "Live Grep in Open Files" }
      end, desc = "[S]earch [/] in Open Files" },
    { "<leader>sn", function()
        require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
      end, desc = "[S]earch [N]eovim files" },
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
    pickers = {
      live_grep = {
        additional_args = function(_) return { "--hidden" } end,
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

