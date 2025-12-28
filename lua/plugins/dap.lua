return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            vim.fn.sign_define("DapBreakpoint", {
                text = "●",
                texthl = "DiagnosticError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointCondition", {
                text = "●",
                texthl = "DiagnosticWarn",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapLogPoint", {
                text = "◆",
                texthl = "DiagnosticInfo",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "",
                texthl = "DiagnosticOk",
                linehl = "DapStoppedLine", -- optional highlight
                numhl = "",
            })

            dapui.setup()

            local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(mason_path)

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
            vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debugger" })
            vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Quit Debugger" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Set Conditional Breakpoint" })
            vim.keymap.set("n", "<leader>dl", function()
                dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
            end, { desc = "Set Log Point" })
            vim.keymap.set("n", "<leader>dt", function()
                dapui.toggle()
            end, { desc = "Toggle DAP UI" })
            vim.keymap.set("n", "<leader>de", function()
                dapui.eval()
            end, { desc = "Evaluate Expression" })
        end,
    },
}
