return {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = { view = "cmdline" },
        lsp = {
            progress = { enabled = false },
            hover = { enabled = false },
            signature = { enabled = false },
        },
        routes = {
            {
                filter = { min_height = 10 },
                view = "split",
            },
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                        { find = "%d fewer lines" },
                        { find = "%d more lines" },
                    },
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "E21",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "W10",
                },
                opts = { skip = true },
            },
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0,
                },
            },
        },
    },
}
