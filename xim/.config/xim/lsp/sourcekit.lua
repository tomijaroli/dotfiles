local function find_xcode_root(start)
  local found = vim.fs.find(function(name)
    return name:match "%.xcodeproj$" or name:match "%.xcworkspace$"
  end, { path = start, upward = true, limit = 1 })[1]
  return found and vim.fs.dirname(found) or nil
end

local cmd = { "sourcekit-lsp" }
if vim.fn.executable "xcrun" == 1 then
  local path = vim.trim(vim.fn.system "xcrun -f sourcekit-lsp")
  if vim.v.shell_error == 0 and path ~= "" then
    cmd = { path }
  end
end

---@type vim.lsp.Config
return {
  cmd = cmd,
  filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
  root_dir = function(bufnr, on_dir)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local start = filename ~= "" and vim.fs.dirname(filename) or vim.uv.cwd()
    on_dir(
      vim.fs.root(start, { "buildServer.json", ".bsp" })
        or find_xcode_root(start)
        or vim.fs.root(start, { "compile_commands.json", "Package.swift" })
        or vim.fs.root(start, ".git")
    )
  end,
  get_language_id = function(_, ftype)
    local t = { objc = "objective-c", objcpp = "objective-cpp" }
    return t[ftype] or ftype
  end,
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
}
