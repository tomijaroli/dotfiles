local function setupListeners()
  local dap = require "dap"
  local areSet = false

  dap.listeners.after["event_initialized"]["me"] = function()
    if not areSet then
      areSet = true
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", noremap = true })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run To Cursor" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
      vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
      vim.keymap.set({ "n", "v" }, "<Leader>de", require("dapui").eval, { desc = "Eval" })
    end
  end

  dap.listeners.after["event_terminated"]["me"] = function()
    if areSet then
      areSet = false
      vim.keymap.del("n", "<leader>dc")
      vim.keymap.del("n", "<leader>dC")
      vim.keymap.del("n", "<leader>ds")
      vim.keymap.del("n", "<leader>di")
      vim.keymap.del("n", "<leader>do")
      vim.keymap.del({ "n", "v" }, "<Leader>dh")
      vim.keymap.del({ "n", "v" }, "<Leader>de")
    end
  end
end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "wojciech-kulik/xcodebuild.nvim",
  },
  config = function()
    local dap = require "dap"
    local xcodebuild = require "xcodebuild.integrations.dap"
    
    -- Enable debug logging to help troubleshoot
    dap.set_log_level('DEBUG')
    
    -- For Xcode 16+, no configuration needed - uses built-in lldb-dap
    -- Optional boolean parameter: loadBreakpoints (default: true)
    xcodebuild.setup()

    local define = vim.fn.sign_define
    define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
    define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
    define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
    define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

    setupListeners()

    --when breakpoint is hit, it sets the focus to the buffer with the breakpoint
    require("dap").defaults.fallback.switchbuf = "usetab,uselast"
    
    -- Clean up debug sessions when Neovim exits
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        pcall(function() dap.terminate() end)
        pcall(function() dap.close() end)
        pcall(function() xcodebuild.terminate_session() end)
      end,
    })

    -- Wrapper to ensure clean debug start
    local function clean_debug_start()
      -- Force terminate any existing session
      pcall(function() dap.terminate() end)
      pcall(function() dap.close() end)
      pcall(function() xcodebuild.terminate_session() end)
      
      -- Kill any lingering processes
      vim.fn.jobstart("pkill -9 lldb-dap; pkill -9 -f 'Wolt Dev'", {
        detach = true,
        on_exit = function()
          -- Wait a moment then start fresh
          vim.defer_fn(function()
            xcodebuild.build_and_debug()
          end, 200)
        end,
      })
    end
    
    vim.keymap.set("n", "<leader>dd", clean_debug_start, { desc = "Build & Debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
    vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })

    vim.keymap.set("n", "<leader>dx", function()
      xcodebuild.terminate_session()
      require("dap").listeners.after["event_terminated"]["me"]()
    end, { desc = "Terminate debugger" })
    
    -- Helper command to view DAP logs for troubleshooting
    vim.api.nvim_create_user_command("DapLogs", function()
      vim.cmd("tabnew " .. vim.fn.stdpath("cache") .. "/dap.log")
    end, { desc = "Open DAP debug logs" })
    
    -- Helper command to inspect DAP configuration
    vim.api.nvim_create_user_command("DapConfig", function()
      print(vim.inspect(dap.adapters))
      print(vim.inspect(dap.configurations))
    end, { desc = "Show DAP configuration" })
  end,
}
