require("lint").linters_by_ft = {
  swift = { "swiftlint" },
  markdown = { "markdownlint" },
}

require "plugins.autocommands.linter"

vim.keymap.set("n", "<leader>ml", function()
  require("lint").try_lint()
end, { desc = "Lint file" })
