return {
    {
        "natecraddock/workspaces.nvim",
        cmd = { "WorkspacesAdd", "WorkspacesList", "WorkspacesOpen", "WorkspacesRemove", "WorkspacesRename" },
        dependencies = { "Shatur/neovim-session-manager" },
        config = function()
            local function dir_to_session_filename(str)
                local Path = require "plenary.path"
                local dir = string.sub(str, 1, -2)
                local filename = dir:gsub(":", "++")
                filename = filename:gsub(Path.path.sep, "__")
                return Path:new(require("session_manager.config").sessions_dir):joinpath(filename)
            end
            require("workspaces").setup {
                sort = true,
                mru_sort = true,
                hooks = {
                    add = { "SessionManager save_current_session" },
                    open_pre = { "SessionManager autosave_session" },
                    open = { "SessionManager load_current_dir_session" },
                    remove = function(_, path)
                        local filename = dir_to_session_filename(path)
                        print(filename)
                        require("plenary.path"):new(filename):rm()
                    end,
                },
            }
        end,
    },
    {
        "Shatur/neovim-session-manager",
        lazy = false,
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
