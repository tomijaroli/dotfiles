require("lazyload").on_vim_enter(function()
  vim.pack.add {
    { src = "https://github.com/mfussenegger/nvim-lint" },
  }

  local lint = require "lint"

  for file_type, language in pairs(Config.languages) do
    if language.linters then
      lint.linters_by_ft[file_type] = language.linters
    end
    if language.linter_config then
      for name, user_config in pairs(language.linter_config) do
        local builtin = lint.linters[name]
        if builtin and type(builtin) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", builtin, user_config)
        else
          lint.linters[name] = user_config
        end
      end
    end
  end

  local function available_linters(file_type)
    local names = lint.linters_by_ft[file_type]
    if type(names) ~= "table" then
      return {}
    end

    local found = {}
    for _, name in ipairs(names) do
      local linter = lint.linters[name]
      if type(linter) == "function" then
        if vim.fn.executable(name) == 1 then
          table.insert(found, name)
        end
      elseif type(linter) == "table" and linter.cmd then
        local cmd = linter.cmd
        if type(cmd) == "table" then
          cmd = cmd[1]
        end
        if type(cmd) == "string" and vim.fn.executable(cmd) == 1 then
          table.insert(found, name)
        end
      elseif linter and vim.fn.executable(name) == 1 then
        table.insert(found, name)
      end
    end
    return found
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("user-auto-lint", { clear = true }),
    callback = function(event)
      local names = available_linters(vim.bo[event.buf].filetype)
      if #names > 0 then
        lint.try_lint(names)
      end
    end,
  })

  vim.keymap.set("n", "<leader>ml", function()
    lint.try_lint()
  end, { desc = "Run [L]int for current buffer" })
end)
