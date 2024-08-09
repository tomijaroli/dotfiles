local function setupListeners()
    local dap = require "dap"
    local didSet = false

    dap.listeners.after.event_initialized["me"] = function()
        if not didSet then
            didSet = true
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
            end, { desc = "Debug: Set Breakpoint" })
            vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover, { desc = "Hover" })
            vim.keymap.set({ "n", "v" }, "<Leader>de", require("dapui").eval, { desc = "Eval" })
        end
    end

    dap.listeners.after.event_terminated["me"] = function()
        if didSet then
            didSet = false
            vim.keymap.del("n", "<F5>")
            vim.keymap.del("n", "<F1>")
            vim.keymap.del("n", "<F2>")
            vim.keymap.del("n", "<F3>")
            vim.keymap.del("n", "<leader>b")
            vim.keymap.del("n", "<leader>B")
            vim.keymap.del({ "n", "v" }, "<Leader>dh")
            vim.keymap.del({ "n", "v" }, "<Leader>de")
        end
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "wojciech-kulik/xcodebuild.nvim",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "leoluz/nvim-dap-go",
            {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    "nvim-neotest/nvim-nio",
                },
            },
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"
            local masondap = require "mason-nvim-dap"
            local dapgo = require "dap-go"

            local xcodebuild = require "xcodebuild.integrations.dap"
            local codelldbPath = os.getenv "HOME" .. "/Developer/codelldb-aarch64-darwin/extension/adapter/codelldb"
            xcodebuild.setup(codelldbPath)

            masondap.setup {
                automatic_setup = true,
                handlers = {},
                ensure_installed = { "delve" },
            }

            local define = vim.fn.sign_define
            define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
            define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
            define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
            define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
            define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

            setupListeners()

            vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
            vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
            vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
            vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
            vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set(
                "n",
                "<leader>B",
                xcodebuild.toggle_message_breakpoint,
                { desc = "Toggle Message Breakpoint" }
            )
            vim.keymap.set("n", "<leader>dx", function()
                xcodebuild.terminate_session()
                require("dap").listeners.after["event_terminated"]["me"]()
            end, { desc = "Terminate debugger" })

            dapui.setup {
                -- icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
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

            vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

            local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })

            -- hide ~ in DAPUI
            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = group,
                pattern = "DAP*",
                callback = function()
                    vim.wo.fillchars = "eob: "
                end,
            })
            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = group,
                pattern = "\\[dap\\-repl\\]",
                callback = function()
                    vim.wo.fillchars = "eob: "
                end,
            })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            dapgo.setup()
        end,
    },
}
