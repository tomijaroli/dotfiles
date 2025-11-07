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
        local linters_by_ft = lint.linters_by_ft or {}
        local ft_linters = linters_by_ft[ft]

        if type(ft_linters) ~= "table" then
          return
        end

        -- filter linters for which executable exists
        local available_linters = {}
        for _, linter_name in ipairs(ft_linters) do
          local linter = lint.linters[linter_name]
          if linter and linter.cmd and vim.fn.executable(linter.cmd) == 1 then
            table.insert(available_linters, linter_name)
          end
        end

        if #available_linters > 0 then
          lint.try_lint(buf, available_linters)
        end
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      lint.try_lint()
    end, { desc = "Run [L]int for current buffer" })
  end,
}
