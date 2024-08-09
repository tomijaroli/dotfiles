local trouble_autocommand_callbacks = require "plugins.autocommands.callbacks.trouble"

vim.api.nvim_create_autocmd("User", {
    pattern = { "XcodebuildBuildFinished", "XcodebuildTestsFinished" },
    callback = trouble_autocommand_callbacks.on_xcodebuild_finished,
})
