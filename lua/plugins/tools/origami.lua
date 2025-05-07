return {
    "chrisgrieser/nvim-origami",
    event = { "BufRead", "BufNewFile" },
    opts = {
        foldtextWithLineCount = {
            template = " %s ",
            hlgroupForCount = "MoreMsg",
        },
        foldKeymaps = {
            hOnlyOpensOnFirstColumn = true,
        },
        keepFoldsAcrossSessions = false,
    },
}
