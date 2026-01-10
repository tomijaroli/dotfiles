return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", "BufWritePost" },
  config = function()
    -- inside config = function()
    local lint_ok, lint = pcall(require, "lint")
    if not lint_ok then
      vim.notify("nvim-lint not available", vim.log.levels.WARN)
      return
    end

    local lang_data = require "plugins.config.lsp.languages"

    lint.linters_by_ft = lint.linters_by_ft or {}
    lint.linters = lint.linters or {}

    -- populate linters and linter configs, but MERGE into builtins if present
    for file_type, language in pairs(lang_data.languages) do
      if language.linters then
        lint.linters_by_ft[file_type] = language.linters
      end

      if language.linter_config then
        for linter_name, user_config in pairs(language.linter_config) do
          local builtin = lint.linters[linter_name]
          if builtin and type(builtin) == "table" then
            lint.linters[linter_name] = vim.tbl_deep_extend("force", builtin, user_config)
          else
            lint.linters[linter_name] = user_config
          end
        end
      end
    end

    -- Safe auto-lint on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = vim.api.nvim_create_augroup("user-auto-lint", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local file_type = vim.bo[buf].filetype
        local ft_linters = lint.linters_by_ft[file_type]

        if type(ft_linters) ~= "table" then
          return
        end

        local available_linters = {}
        for _, linter_name in ipairs(ft_linters) do
          local linter = lint.linters[linter_name]
          
          -- Handle both function (built-in linters) and table (custom linters)
          local cmd_to_test = nil
          if type(linter) == "function" then
            -- Built-in linter - it's a function that returns config
            -- Just check if the command exists by name
            if vim.fn.executable(linter_name) == 1 then
              table.insert(available_linters, linter_name)
            end
          elseif type(linter) == "table" and linter.cmd then
            -- Custom linter - it's a table with cmd field
            cmd_to_test = linter.cmd
            if type(cmd_to_test) == "table" then
              cmd_to_test = cmd_to_test[1]
            end
            if type(cmd_to_test) == "string" and vim.fn.executable(cmd_to_test) == 1 then
              table.insert(available_linters, linter_name)
            end
          elseif linter then
            -- Linter exists but we can't determine availability - add it anyway
            table.insert(available_linters, linter_name)
          end
        end

        if #available_linters > 0 then
          lint.try_lint(available_linters)
        end
      end,
    })

    vim.keymap.set("n", "<leader>ml", function()
      lint.try_lint()
    end, { desc = "Run [L]int for current buffer" })
  end,
}
