return {
    "EdenEast/nightfox.nvim",
    config = function()
        require("nightfox").setup({
            options = {
                transparent = not vim.g.neovide,
            },
            groups = {
                all = {
                    NormalFloat = { fg = "fg1", bg = "NONE", },
                    WinSeparator = { fg = "#8b8b8b", bg = "NONE", },
                },
            },
        })
    end
}
