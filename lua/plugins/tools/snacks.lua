return {
    "folke/snacks.nvim",
    event = { "User AfterLoad", "BufRead", "LspAttach" },
    ---@type snacks.Config
    opts = {
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1024 * 1024 * 1.5, -- 1.5MB
            setup = function(ctx)
                vim.cmd [[NoMatchParen]]
                require("snacks").util.wo(0, { foldmethod = "manual", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    vim.bo[ctx.buf].syntax = ctx.ft
                end)
            end,
        },
        indent = {
            indent = {
                enabled = true,
                char = "│",
            },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and vim.bo[buf].filetype ~= "oil"
                    and vim.bo[buf].filetype ~= ""
            end,
        },
    },
}
