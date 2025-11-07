return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", "BufWritePost" },
  config = function()
    local lint_ok, lint = pcall(require, "lint")
    if not lint_ok then
      vim.notify("nvim-lint not available", vim.log.levels.WARN)
      return
    end

    lint.linters_by_ft.lua = { "luacheck" }
    lint.linters_by_ft.swift = { "swiftlint" }
    lint.linters_by_ft.python = { "ruff" }
    lint.linters_by_ft.javascript = { "eslint_d" }
    lint.linters_by_ft.typescript = { "eslint_d" }
    lint.linters_by_ft.sh = { "shellcheck" }
    lint.linters_by_ft.bash = { "shellcheck" }
    lint.linters_by_ft.zsh = { "shellcheck" }

    lint.linters.luacheck = {
      cmd = "luacheck",
      stdin = false,
      args = { "--codes", "--std", "lua54" },
      ignore_exitcode = true,
    }

    -- Safe auto-lint on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("UserAutoLint", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        local linters_by_ft_ok, linters_by_ft = pcall(function()
          return lint.linters_by_ft
        end)
        if not linters_by_ft_ok or type(linters_by_ft) ~= "table" then
          vim.notify("[nvim-lint] linters_by_ft is not a table (skipping lint).", vim.log.levels.WARN)
          return
        end

        local ft_linters = linters_by_ft[ft]
        if type(ft_linters) ~= "table" then
          -- Nothing configured for this filetype or value is invalid → skip
          return
        end

        local try_link_ok, err = pcall(function()
          lint.try_lint()
        end)
        if not try_link_ok then
          vim.notify("[nvim-lint] try_lint failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      lint.try_lint()
    end, { desc = "Run [L]int for current buffer" })
  end,
}
