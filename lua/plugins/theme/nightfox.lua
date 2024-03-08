---@diagnostic disable: undefined-global
return {
    "EdenEast/nightfox.nvim",
    priority = 100,
    config = function()
        -- local C = require("nightfox.palette").load "nordfox"
        -- local CmpText = "#ffffff"
        require("nightfox").setup {
            options = {
                transparent = not vim.g.neovide,
                modules = { cmp = { enable = true } },
                styles = {
                    comments = "italic",
                    keywords = "bold",
                    types = "italic,bold",
                },
            },
            groups = {
                all = {
                    NormalFloat = { fg = "fg1", bg = "NONE" },
                    WinSeparator = { fg = "#7c7c7c", bg = "NONE" },
                },
            },
        }
    end,
}
