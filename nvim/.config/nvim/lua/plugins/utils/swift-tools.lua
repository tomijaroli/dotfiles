local M = {}

local uv = vim.loop

local function path_exists(path)
  return path and #path > 0 and uv.fs_stat(path)
end

local function expand_home(path)
  return path and path:gsub("^~", vim.fn.expand "~") or path
end

local function git_toplevel(startpath)
  if not startpath or #startpath == 0 then
    return nil
  end
  local startdir = vim.fn.fnamemodify(startpath, ":h")
  local ok, result = pcall(vim.fn.systemlist, { "git", "-C", startdir, "rev-parse", "--show-toplevel" })
  if not ok or not result or #result == 0 then
    return nil
  end
  return result[1]
end

local function repo_root()
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if root and #root > 0 and path_exists(root) then
    return root
  end
  return uv.cwd()
end

local function find_config_file(ctx, patterns, env_var)
  if not ctx or not ctx.filename then
    return nil
  end

  -- 1. Search upward from current file
  local local_cfg = vim.fs.find(patterns, { path = ctx.filename, upward = true })[1]
  if path_exists(local_cfg) then
    return { mode = "local", path = local_cfg }
  end

  -- 2. Check environment variable if provided
  if env_var then
    local env_cfg = os.getenv(env_var)
    if path_exists(env_cfg) then
      return { mode = "env", path = env_cfg }
    end
  end

  -- 3. Check git repo root
  local toplevel = git_toplevel(ctx.filename)
  if path_exists(toplevel) then
    for _, pattern in ipairs(patterns) do
      local repo_cfg = toplevel .. "/" .. pattern
      if path_exists(repo_cfg) then
        return { mode = "repo", path = repo_cfg }
      end
    end
  end

  -- 4. Check user home directory
  for _, pattern in ipairs(patterns) do
    local home_cfg = expand_home("~/" .. pattern)
    if path_exists(home_cfg) then
      return { mode = "user", path = home_cfg }
    end
  end

  -- 5. Check XDG config directory
  for _, pattern in ipairs(patterns) do
    local config_name = pattern:match "^%.(.+)$" or pattern
    local xdg_cfg = expand_home("~/.config/" .. config_name .. "/" .. pattern)
    if path_exists(xdg_cfg) then
      return { mode = "user", path = xdg_cfg }
    end
  end

  return nil
end

local function find_swiftformat_for(ctx)
  return find_config_file(ctx, { ".swiftformat" }, "SWIFTFORMAT_CONFIG")
end

local function find_swiftlint_for(ctx)
  return find_config_file(ctx, { ".swiftlint.yml", ".swiftlint.yaml" }, "SWIFTLINT_CONFIG")
end

local function swiftformat_args_flexible(ctx)
  -- Defensive: ensure we have a filename
  local filename = ctx and ctx.filename
  if not filename or filename == "" then
    -- Fallback to current buffer name if ctx.filename is missing
    filename = vim.api.nvim_buf_get_name(0)
    if filename == "" then
      vim.notify("SwiftFormat: No filename available in context", vim.log.levels.WARN)
      return { "--stdin-path", "unnamed.swift" }
    end
  end

  local found = find_swiftformat_for(ctx or { filename = filename })

  local args
  if not found then
    args = { "--stdin-path", filename }
  elseif found.mode == "local" then
    args = { "--stdin-path", filename }
  else
    args = { "--config", found.path, "--stdin-path", filename }
  end

  return args
end

local function swiftlint_args_flexible(ctx)
  -- SwiftLint doesn't use stdin, it lints the file directly
  -- So we just need to return the config path if found
  local filename = ctx and ctx.filename
  if not filename or filename == "" then
    -- Fallback to current buffer name if ctx.filename is missing
    filename = vim.api.nvim_buf_get_name(0)
  end

  local found = find_swiftlint_for(ctx or { filename = filename })

  local args = {}
  if found then
    -- Add --config argument if a config file was found
    table.insert(args, "--config")
    table.insert(args, found.path)
  end

  return args
end

M.path_exists = path_exists
M.expand_home = expand_home
M.git_toplevel = git_toplevel
M.repo_root = repo_root
M.find_config_file = find_config_file
M.find_swiftformat_for = find_swiftformat_for
M.find_swiftlint_for = find_swiftlint_for
M.swiftformat_args_flexible = swiftformat_args_flexible
M.swiftlint_args_flexible = swiftlint_args_flexible

return M
