---@diagnostic disable: unused-local
return {
    "neanias/everforest-nvim",
    lazy = true,
    config = function()
        require("everforest").setup {
            italics = true,
            on_highlights = function(hl, pl)
                hl.MiniFilesTitleFocused = { fg = "fg", bg = pl.bg0 }
            end,
        }
    end,
}
