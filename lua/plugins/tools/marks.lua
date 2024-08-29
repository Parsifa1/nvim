return {
    "chentoast/marks.nvim",
    enabled = false,
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        require("marks").setup {}
    end,
}
