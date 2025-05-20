return {
    "chrisgrieser/nvim-origami",
    event = { "BufRead", "BufNewFile" },
    opts = {
        keepFoldsAcrossSessions = false,
        foldKeymaps = { hOnlyOpensOnFirstColumn = true, },
    },
}
