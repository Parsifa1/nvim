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
            { ft = "NeogitStatus", size = { height = 15 } },
            { ft = "spectre_panel", size = { height = 15 } },
        },
        right = {
            {
                ft = "Outline",
                pinned = true,
                open = "SymbolsOutlineOpen",
                size = { width = 35 },
            },
        },
    },
}
