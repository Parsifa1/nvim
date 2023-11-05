return {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        -- routes = {
        --     {
        --         view = "notify",
        --         filter = { event = "msg_showmode" },
        --     },
        -- },
        cmdline = { view = "cmdline" },
        lsp = {
            progress = { enabled = false },
            hover = { enabled = false },
            signature = { enabled = false },

        }
    }
}
