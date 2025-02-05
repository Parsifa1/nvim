(vim.fn.sign_define :DapBreakpoint {:text "" :texthl :DiagnosticError})
(vim.fn.sign_define :DapLogPoint {:text "" :texthl :DiagnosticInfo})
(vim.fn.sign_define :DapStopped {:text "" :texthl :Constant})
(vim.fn.sign_define :DapBreakpointRejected {:text ""})

(local nvim-dap {1 :mfussenegger/nvim-dap
                 :config (fn []
                           (local dap (require :dap))
                           (set dap.adapters.codelldb
                                {:command :codelldb :type :executable})
                           (set dap.configurations.cpp
                                [{:breakpointMode :file
                                  :cwd "${fileDirname}"
                                  :name "Launch file"
                                  :program (fn []
                                             (vim.cmd "cd %:h")
                                             (vim.cmd "silent w !g++ %:t -g -std=c++20 -o bin/%:t:r")
                                             (local file-name
                                                    (vim.fn.bufname (vim.api.nvim_get_current_buf)))
                                             (local file-name-without-path
                                                    (vim.fn.fnamemodify file-name
                                                                        ":t"))
                                             (local file-directory
                                                    (vim.fn.expand "%:p:h"))
                                             (when (not= file-name-without-path
                                                         0)
                                               (.. file-directory :/bin/
                                                   (file-name-without-path:gsub "%.cpp$"
                                                                                ""))))
                                  :request :launch
                                  :stopAtEntry true
                                  :type :codelldb}])
                           (local dapui (require :dapui))
                           (dapui.setup {})

                           (fn dap.listeners.after.event_initialized.dapui_config []
                             (dapui.open {}))

                           (fn dap.listeners.before.event_terminated.dapui_config []
                             (dapui.close {}))

                           (fn dap.listeners.before.event_exited.dapui_config []
                             (dapui.close {})))
                 :dependencies [:rcarriga/nvim-dap-ui
                                :theHamsta/nvim-dap-virtual-text]
                 :ft [:cpp]
                 :keys [{1 :<F8>
                         2 (fn []
                             ((. (require :dap) :toggle_breakpoint)))
                         :desc "Debug: Toggle breakpoint"}
                        {1 :<F9>
                         2 (fn []
                             ((. (require :dap) :continue)))
                         :desc "Debug: Continue"}
                        {1 :<F10>
                         2 (fn []
                             ((. (require :dap) :step_into)))
                         :desc "Debug: Step into"}
                        {1 :<F11>
                         2 (fn []
                             ((. (require :dap) :step_over)))
                         :desc "Debug: Step over"}
                        {1 :<F12>
                         2 (fn []
                             ((. (require :dap) :step_out)))
                         :desc "Debug: Step out"}
                        {1 :<leader>dp
                         2 (fn []
                             ((. (require :dap) :set_breakpoint) nil nil
                                                                 (vim.fn.input "Log point message: ")))
                         :desc "Set log point"}
                        {1 :<leader>dr
                         2 (fn []
                             ((. (require :dap) :repl :toggle)))
                         :desc "Toggle REPL"}
                        {1 :<leader>dl
                         2 (fn []
                             ((. (require :dap) :run_last)))
                         :desc "Run last"}]
                 :specs [:nvim-neotest/nvim-nio]})

(local mason-dap {1 :jay-babu/mason-nvim-dap.nvim
                  :dependencies [:mason.nvim]
                  :lazy true
                  :opts {}})

[nvim-dap mason-dap]
