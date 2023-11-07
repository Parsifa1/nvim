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

        }
    }
}
