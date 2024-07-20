return {
    "chentoast/marks.nvim",
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        require("marks").setup {}
    end,
}
