return {
    "folke/snacks.nvim",
    event = { "BufRead", "LspAttach" },
    opts = {
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1024 * 1024 * 0.39, -- 1.5MB
            setup = function(ctx)
                vim.cmd [[NoMatchParen]]
                require("snacks").util.wo(0, { foldmethod = "manual", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    vim.bo[ctx.buf].syntax = ctx.ft
                end)
            end,
        },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
}
