return {
    "chrisgrieser/nvim-origami",
    event = "BufReadPost", -- later or on keypress would prevent saving folds
    opts = {
        hOnlyOpensOnFirstColumn = true,
    }, -- needed even when using default config
}
