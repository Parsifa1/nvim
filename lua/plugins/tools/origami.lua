return {
    "chrisgrieser/nvim-origami",
    event = { "BufRead", "BufNewFile" },
    opts = {
        foldKeymaps = {
            hOnlyOpensOnFirstColumn = true,
        },
        keepFoldsAcrossSessions = false,
    },
}
