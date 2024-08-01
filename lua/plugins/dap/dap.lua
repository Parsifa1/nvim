vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    specs = { "nvim-neotest/nvim-nio" },
    config = function()
        local dap = require "dap"
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" },
            },
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    vim.cmd "cd %:h"
                    vim.cmd "silent w !g++ %:t -g -std=c++20 -o bin/%:t:r"
                    local file_name = vim.fn.bufname(vim.api.nvim_get_current_buf())
                    local file_name_without_path = vim.fn.fnamemodify(file_name, ":t")
                    local file_directory = vim.fn.expand "%:p:h"
                    if file_name_without_path ~= 0 then
                        return file_directory .. "/bin/" .. file_name_without_path:gsub("%.cpp$", "")
                    end
                end,
                cwd = "${fileDirname}",
                stopAtEntry = true,
                -- miDebuggerPath = '/usr/bin/gdb',
                -- setupCommands = {
                --     {
                --         text = '-enable-pretty-printing',
                --         description = 'enable pretty printing',
                --         ignoreFailures = false
                --     },
                -- },
            },
        }
        local dapui = require "dapui"
        dapui.setup {}

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open {}
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close {}
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close {}
        end
    end,
    keys = {
        {
            "<F8>",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Debug: Toggle breakpoint",
        },
        {
            "<F9>",
            function()
                require("dap").continue()
            end,
            desc = "Debug: Continue",
        },
        {
            "<F10>",
            function()
                require("dap").step_into()
            end,
            desc = "Debug: Step into",
        },
        {
            "<F11>",
            function()
                require("dap").step_over()
            end,
            desc = "Debug: Step over",
        },
        {
            "<F12>",
            function()
                require("dap").step_out()
            end,
            desc = "Debug: Step out",
        },

        {
            "<leader>db",
            function()
                require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
            end,
            desc = "Set breakpoint",
        },
        {
            "<leader>dp",
            function()
                require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
            end,
            desc = "Set log point",
        },
        {
            "<leader>dr",
            function()
                require("dap").repl.toggle()
            end,
            desc = "Toggle REPL",
        },
        {
            "<leader>dl",
            function()
                require("dap").run_last()
            end,
            desc = "Run last",
        },
    },
}
