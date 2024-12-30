return {
    "yetone/avante.nvim",
    build = "make",
    opts = {
        provider = "copilot",
        copilot = {
            model = "claude-3.5-sonnet",
        },
        hints = { enabled = false },
    },
    keys = {
        {
            "<leader>aa",
            function()
                require("avante.api").ask()
            end,
            desc = "avante: ask",
            mode = { "n", "v" },
        },
        {
            "<leader>ar",
            function()
                require("avante.api").refresh()
            end,
            desc = "avante: refresh",
        },
        {
            "<leader>ae",
            function()
                require("avante.api").edit()
            end,
            desc = "avante: edit",
            mode = "v",
        },
    },
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.icons",
        "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
}
