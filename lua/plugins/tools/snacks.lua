return {
    "folke/snacks.nvim",
    event = { "BufRead", "LspAttach" },
    opts = {
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1024 * 1024 * 0.39, -- 1.5MB
        },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
}
