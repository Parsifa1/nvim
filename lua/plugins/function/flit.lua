return {
    "ggandor/flit.nvim",
    lazy = true,
    keys = { "f", "F", "t", "T" },
    dependencies = { "ggandor/leap.nvim" },
    config = function()
        require("flit").setup({
            keys = { f = "f", F = "F", t = "t", T = "T", },
            labeled_modes = "v",
            multiline = true,
            opts = {},
        })
    end,
}
