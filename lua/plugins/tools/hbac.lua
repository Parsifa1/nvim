return {
    "axkirillov/hbac.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("hbac").setup {
            autoclose = true,
            threshold = 5,
        }
    end,
}
