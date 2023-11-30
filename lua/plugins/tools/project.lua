return {
    "coffebar/neovim-project",
    opts = {
        last_session_on_startup = false,
        projects = { -- define project roots
            "~/CodeField/",
            "~/CodeField/C++",
            "~/CodeField/Python",
            "~/CodeField/Rust/",
            "~/.config/nvim",
            "/mnt/c/Users/Parsifal/AppData/Roaming/Rime",
            "/mnt/c/Users/Parsifal/",
        },
    },
    init = function()
        -- enable saving the state of plugins in the session
        vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
        { "Shatur/neovim-session-manager" },
    },
    event = "VeryLazy",

}
