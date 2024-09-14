return {
    "yetone/avante.nvim",
    build = "make",
    opts = {
        provider = "copilot",
        -- claude = {
        --     endpoint = "https://apic.ohmygpt.com/",
        --     model = "claude-3-5-sonnet-20240620",
        -- },
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
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua",      -- for providers='copilot'
    },
}
