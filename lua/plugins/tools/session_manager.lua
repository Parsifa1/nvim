return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader><Tab>", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
        { "<leader>i", "<cmd>SessionManager load_session<CR><esc>", desc = "Session Picker" },
    },
    lazy = false,
    config = function()
        require("session_manager").setup {
            autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
            autosave_ignore_filetypes = { "gitcommit", "gitrebase", "toggleterm", "help", "lazy", "codecompanion" },
            autosave_ignore_buftypes = { "terminal" },
            autosave_only_in_session = true,
        }
    end,
}
