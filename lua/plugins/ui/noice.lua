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
                filter = { event = "msg_show", find = "written" },
                opts = { skip = true },
            },
            {
                view = "split",
                filter = { event = "msg_show", min_height = 20 },
            },
            {
                filter = { event = "msg_show", find = "attempt to index local 'tree'" },
                opts = { skip = true },
            },
            {
                filter = { event = "msg_show", find = "Invalid 'window': Expected Lua number" },
                opts = { skip = true },
            }

        },
    },
}
