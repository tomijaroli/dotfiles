local lazyload = require "lazyload"

local ios_dap = {}

local setup = lazyload.once(function()
  if Config.ensure_picker then
    Config.ensure_picker()
  end
  vim.pack.add {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/wojciech-kulik/xcodebuild.nvim" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
  }

  local pickers = require "xcodebuild.ui.pickers"
  pickers.setup = function() end
  local upvalue_index = 1
  while true do
    local name = debug.getupvalue(pickers.show, upvalue_index)
    if not name then
      error "xcodebuild.ui.pickers is missing the integration upvalue"
    end
    if name == "integration" then
      debug.setupvalue(pickers.show, upvalue_index, require "ios.xcodebuild-pick")
      break
    end
    upvalue_index = upvalue_index + 1
  end

  require("xcodebuild").setup {
    show_build_progress_bar = false,
    integrations = {
      telescope_nvim = { enabled = false },
      snacks_nvim = { enabled = false },
      fzf_lua = { enabled = false },
      pymobiledevice = {
        enabled = true,
      },
    },
    logs = {
      auto_open_on_success_tests = false,
      auto_open_on_failed_tests = true,
      auto_open_on_success_build = false,
      auto_open_on_failed_build = true,
      auto_focus = false,
      auto_close_on_app_launch = true,
      only_summary = true,
      notify = function(message, severity)
        if vim.trim(message) ~= "" then
          vim.notify(message, severity)
        end
      end,
      notify_progress = function(message)
        vim.api.nvim_echo({ { message, "None" } }, false, {})
      end,
    },
    code_coverage = {
      enabled = true,
    },
  }

  local dap = require "dap"
  local dapui = require "dapui"
  local xcodebuild = require "xcodebuild.integrations.dap"

  dap.set_log_level "DEBUG"
  xcodebuild.setup()
  ios_dap.xcodebuild = xcodebuild
  ios_dap.dap = dap

  local define = vim.fn.sign_define
  define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
  define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
  define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

  dap.defaults.fallback.switchbuf = "usetab,uselast"

  dapui.setup {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        run_last = "",
        terminate = "⏹︎",
        pause = "⏸︎",
        play = "",
        step_into = "󰆹",
        step_out = "󰆸",
        step_over = "",
        step_back = "",
      },
    },
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    icons = {
      collapsed = "",
      expanded = "",
      current_frame = "",
    },
    layouts = {
      {
        elements = {
          { id = "stacks", size = 0.25 },
          { id = "scopes", size = 0.25 },
          { id = "breakpoints", size = 0.25 },
          { id = "watches", size = 0.25 },
        },
        position = "left",
        size = 40,
      },
      {
        elements = {
          { id = "repl", size = 0.4 },
          { id = "console", size = 0.6 },
        },
        position = "bottom",
        size = 10,
      },
    },
  }

  local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })
  vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    pattern = { "DAP*", "\\[dap\\-repl\\]" },
    callback = function()
      vim.wo.fillchars = "eob: "
    end,
  })

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  local session_maps = false
  dap.listeners.after["event_initialized"]["me"] = function()
    if session_maps then
      return
    end
    session_maps = true
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", noremap = true })
    vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run To Cursor" })
    vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
    vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>de", dapui.eval, { desc = "Eval" })
  end
  dap.listeners.after["event_terminated"]["me"] = function()
    if not session_maps then
      return
    end
    session_maps = false
    vim.keymap.del("n", "<leader>dc")
    vim.keymap.del("n", "<leader>dC")
    vim.keymap.del("n", "<leader>ds")
    vim.keymap.del("n", "<leader>di")
    vim.keymap.del("n", "<leader>do")
    vim.keymap.del({ "n", "v" }, "<Leader>dh")
    vim.keymap.del({ "n", "v" }, "<Leader>de")
  end

  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      pcall(dap.terminate)
      pcall(dap.close)
      pcall(xcodebuild.terminate_session)
    end,
  })

  ios_dap.start = function()
    pcall(dap.terminate)
    pcall(dap.close)
    pcall(xcodebuild.terminate_session)
    vim.fn.jobstart("pkill -9 lldb-dap", {
      detach = true,
      on_exit = function()
        vim.defer_fn(function()
          xcodebuild.build_and_debug()
        end, 200)
      end,
    })
  end

  vim.api.nvim_create_user_command("DapLogs", function()
    vim.cmd("tabnew " .. vim.fn.stdpath "cache" .. "/dap.log")
  end, { desc = "Open DAP debug logs" })
  vim.api.nvim_create_user_command("DapConfig", function()
    print(vim.inspect(dap.adapters))
    print(vim.inspect(dap.configurations))
  end, { desc = "Show DAP configuration" })
end)

local function xcmd(command)
  return function()
    setup()
    vim.cmd(command)
  end
end

vim.keymap.set("n", "<leader>X", xcmd "XcodebuildPicker", { desc = "Show Xcodebuild Actions" })
vim.keymap.set("n", "<leader>xf", xcmd "XcodebuildProjectManager", { desc = "Show Project Manager Actions" })
vim.keymap.set("n", "<leader>xb", xcmd "XcodebuildBuild", { desc = "Build Project" })
vim.keymap.set("n", "<leader>xB", xcmd "XcodebuildBuildForTesting", { desc = "Build For Testing" })
vim.keymap.set("n", "<leader>xr", xcmd "XcodebuildBuildRun", { desc = "Build & Run Project" })
vim.keymap.set("n", "<leader>xt", xcmd "XcodebuildTest", { desc = "Run Tests" })
vim.keymap.set("v", "<leader>xt", xcmd "XcodebuildTestSelected", { desc = "Run Selected Tests" })
vim.keymap.set("n", "<leader>xT", xcmd "XcodebuildTestClass", { desc = "Run This Test Class" })
vim.keymap.set("n", "<leader>xl", xcmd "XcodebuildToggleLogs", { desc = "Toggle Xcodebuild Logs" })
vim.keymap.set("n", "<leader>xc", xcmd "XcodebuildToggleCodeCoverage", { desc = "Toggle Code Coverage" })
vim.keymap.set("n", "<leader>xC", xcmd "XcodebuildShowCodeCoverageReport", { desc = "Show Code Coverage Report" })
vim.keymap.set("n", "<leader>xe", xcmd "XcodebuildTestExplorerToggle", { desc = "Toggle Test Explorer" })
vim.keymap.set("n", "<leader>xs", xcmd "XcodebuildFailingSnapshots", { desc = "Show Failing Snapshots" })
vim.keymap.set("n", "<leader>xd", xcmd "XcodebuildSelectDevice", { desc = "Select Device" })
vim.keymap.set("n", "<leader>xp", xcmd "XcodebuildSelectTestPlan", { desc = "Select Test Plan" })
vim.keymap.set("n", "<leader>xq", function()
  if Config.ensure_picker then
    Config.ensure_picker()
  end
  require("mini.extra").pickers.list { scope = "quickfix" }
end, { desc = "Show QuickFix List" })
vim.keymap.set("n", "<leader>xx", xcmd "XcodebuildQuickfixLine", { desc = "Quickfix Line" })
vim.keymap.set("n", "<leader>xa", xcmd "XcodebuildCodeActions", { desc = "Show Xcode Code Actions" })

vim.keymap.set("n", "<leader>dd", function()
  setup()
  ios_dap.start()
end, { desc = "Build & Debug" })
vim.keymap.set("n", "<leader>dr", function()
  setup()
  ios_dap.xcodebuild.debug_without_build()
end, { desc = "Debug Without Building" })
vim.keymap.set("n", "<leader>dt", function()
  setup()
  ios_dap.xcodebuild.debug_tests()
end, { desc = "Debug Tests" })
vim.keymap.set("n", "<leader>dT", function()
  setup()
  ios_dap.xcodebuild.debug_class_tests()
end, { desc = "Debug Class Tests" })
vim.keymap.set("n", "<leader>b", function()
  setup()
  ios_dap.xcodebuild.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
  setup()
  ios_dap.xcodebuild.toggle_message_breakpoint()
end, { desc = "Toggle Message Breakpoint" })
vim.keymap.set("n", "<leader>dx", function()
  setup()
  ios_dap.xcodebuild.terminate_session()
  ios_dap.dap.listeners.after["event_terminated"]["me"]()
end, { desc = "Terminate debugger" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-xcodebuild", { clear = true }),
  pattern = "swift",
  once = true,
  callback = function()
    vim.schedule(setup)
  end,
})
