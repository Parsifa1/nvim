return {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function ()
        require('onedark').setup {
            highlights = {
                NormalFloat = { fg = "Fg", bg = "NONE" },
                FloatBorder = { fg = "Fg", bg = "NONE", },
                WinBar = { fg = "Fg", bg = "NONE", },
            }
        }
    end
}
