return {
    {
        "natecraddock/workspaces.nvim",
        dependencies = { "Shatur/neovim-session-manager" },
        config = function()
            require("workspaces").setup {
                auto_open = true,
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
        -- lazy = true,
        config = function()
            require("session_manager").setup {
                autoload_mode = "Disabled",
                autosave_ignore_filetypes = {
                    "gitcommit",
                    "gitrebase",
                    "toggleterm",
                },
                autosave_ignore_buftypes = {
                    "terminal",
                },
            }
        end,
    },
}
-- local function load_workspace(path)
--     require("session_manager").autosave_session()
--     local target = require("session_manager.config").dir_to_session_filename(path)
--     -- if target:exists() then
--     local filename = string.gsub(target.filename, "__$", "", 1)
--     require("session_manager").autosave_session()
--     require("session_manager.utils").load_session(filename, false)
--     -- end
-- end
