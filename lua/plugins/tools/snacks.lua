return {
    "folke/snacks.nvim",
    event = { "User AfterLoad", "LspAttach" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
}
