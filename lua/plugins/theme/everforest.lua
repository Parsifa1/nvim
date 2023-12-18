return {
    "neanias/everforest-nvim",
    lazy = true,
    config = function()
        require("everforest").setup({
            italics = true,
            on_highlights = function(hl, palette)
                hl.NormalFloat = { fg = "fg", bg = "NONE", }
                hl.FloatBorder = { fg = "fg", bg = "NONE", }
                hl.WinBar = { fg = "fg", bg = "NONE", }
            end
        })
    end
}
