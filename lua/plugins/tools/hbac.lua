return {
    "axkirillov/hbac.nvim",
    event = "VeryLazy",
    config = function()
        require("hbac").setup {
            autoclose = true,
            threshold = 5,
        }
    end,
}
