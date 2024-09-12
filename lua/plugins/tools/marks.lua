return {
    "chentoast/marks.nvim",
    enabled = false,
    event = "User AfterLoad",
    config = function()
        require("marks").setup {}
    end,
}
