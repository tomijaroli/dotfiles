return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", "BufWritePost" },
  config = function()
    local lint_ok, lint = pcall(require, "lint")
    if not lint_ok then
      vim.notify("nvim-lint not available", vim.log.levels.WARN)
      return
    end

    local lang_data = require "plugins.config.lsp.languages"

    -- Extract linters_by_ft from languages table
    for ft, language in pairs(lang_data.languages) do
      if language.linters then
        lint.linters_by_ft[ft] = language.linters
      end

      if language.linter_config then
        for linter_name, config in pairs(language.linter_config) do
          lint.linters[linter_name] = config
        end
      end
    end

    -- Safe auto-lint on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("UserAutoLint", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local ft_linters = lint.linters_by_ft[ft]

        if type(ft_linters) ~= "table" then
          return
        end

        local available_linters = {}
        for _, linter_name in ipairs(ft_linters) do
          local linter = lint.linters[linter_name]
          if linter and linter.cmd and vim.fn.executable(linter.cmd) == 1 then
            table.insert(available_linters, linter_name)
          end
        end

        if #available_linters > 0 then
          -- **Do not pass `buf` here**, only the list of linters
          lint.try_lint(available_linters)
        end
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      lint.try_lint()
    end, { desc = "Run [L]int for current buffer" })
  end,
}
