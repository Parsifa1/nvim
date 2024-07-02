---@diagnostic disable: undefined-global
return {
    "EdenEast/nightfox.nvim",
    priority = 100,
    config = function()
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
                    TelescopePreviewTitle = { fg = "fg0", bg = "#668aab" },
                    TelescopePromptTitle = { fg = "fg0", bg = "#a96ca5" },
                    TelescopeResultsTitle = { fg = "fg0", bg = "#c9826b" },
                },
            },
        }
    end,
}
