---@type LazyPluginSpec[]
return {
    {
        "parsifa1/neovim-session-manager",
        branch = "resession-backend",
        dependencies = { "stevearc/dressing.nvim" },
        keys = {
            { "<leader><Tab>", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
            { "<leader>i", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
        },
        lazy = false,
        config = function()
            local config = require "session_manager.config"
            require("session_manager").setup {
                resession_backend = true,
                autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
                autosave_ignore_filetypes = { "gitcommit", "gitrebase", "toggleterm", "help", "lazy", "codecompanion" },
                autosave_ignore_buftypes = { "terminal" },
                autosave_only_in_session = true,
            }
        end,
    },
    {
        "parsifa1/resession.nvim",
        branch = "fix-separator",
        event = { "BufRead", "BufNewFile" },
        opts = {
            buf_filter = function(bufnr)
                local buftype = vim.bo[bufnr].buftype
                if
                    not buftype == "help"
                    or (buftype ~= "" and buftype ~= "acwrite")
                    or vim.api.nvim_buf_get_name(bufnr) == ""
                then
                    return false
                end
                return true
            end,
            extensions = { scope = {} },
        },
    },
    {
        "tiagovla/scope.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },
}
