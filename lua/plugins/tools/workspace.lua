return {
    "natecraddock/workspaces.nvim",
    dependencies = { "natecraddock/sessions.nvim" },
    event = "VeryLazy",
    config = function()
        require("telescope").load_extension "workspaces"
        require("sessions").setup {
            events = { "WinEnter" },
            absolute = true,
            session_filepath = vim.fn.stdpath "data" .. "/sessions",
        }
        require("workspaces").setup {
            sort = true,
            mru_sort = true,
            progress_ttl = 30,
            hooks = {
                add = {
                    "SessionsSave",
                },
                open_pre = {
                    "SessionsStop",
                    "silent %bdelete!",
                },
                open = function()
                    require("sessions").load(nil, { silent = true })
                    -- MiniFiles.open()
                end,
            },
        }
    end,
}
