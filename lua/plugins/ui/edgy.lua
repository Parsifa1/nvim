return {
    "folke/edgy.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
        bottom = {
            {
                ft = "Trouble",
                size = { height = 15 },
            },
            { ft = "qf", title = "QuickFix" },
            {
                ft = "help",
                size = { height = 20 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
        },
        right = {
            {
                ft = "Outline",
                pinned = true,
                open = "SymbolsOutlineOpen",
                size = { width = 35 },
            },
        },
        exit_when_last = true,
    },
}
