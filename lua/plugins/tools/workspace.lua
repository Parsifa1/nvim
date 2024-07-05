return {
    {
        "natecraddock/workspaces.nvim",
        cmd = {
            "WorkspacesAdd",
            "WorkspacesList",
            "WorkspacesOpen",
            "WorkspacesRemove",
            "WorkspacesRename",
        },
        dependencies = { "Shatur/neovim-session-manager" },
        config = function()
            require("workspaces").setup {
                sort = true,
                mru_sort = true,
                hooks = {
                    add = { "SessionManager save_current_session" },
                    open_pre = { "SessionManager autosave_session" },
                    open = { "SessionManager load_current_dir_session" },
                },
            }
        end,
    },
    {
        "Shatur/neovim-session-manager",
        lazy = false,
        -- event = "VeryLazy",
        config = function()
            require("session_manager").setup {
                autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
                autosave_only_in_session = true,
                autosave_ignore_filetypes = {
                    "gitcommit",
                    "gitrebase",
                    "toggleterm",
                    "help",
                },
                autosave_ignore_buftypes = { "terminal" },
            }
        end,
    },
}
