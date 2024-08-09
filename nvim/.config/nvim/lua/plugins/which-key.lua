return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local which_key = require "which-key"
        which_key.setup()

        which_key.add {
            { "<leader>c", group = "[C]ode" },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>g", group = "[G]itsign" },
            { "<leader>d_", hidden = true },
            { "<leader>r", group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>t", group = "[T]ab management" },
            { "<leader>x", group = "[x]codebuild actions" },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>w_", hidden = true },
        }
    end,
}
