return {
    "EdenEast/nightfox.nvim",
    config = function()
        require("nightfox").setup({
            options = {
                transparent = true,
            },
            groups = {
                all = {
                    NormalFloat = { fg = "fg1", bg = "NONE", },
                },
            },
        })
    end
}
