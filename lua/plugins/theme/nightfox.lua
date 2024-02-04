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
                    WinSeparator = { fg = "#7c7c7c", bg = "NONE", },
                },
            },
        })
    end
}
