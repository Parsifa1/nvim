return {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("notify").setup {
            stages = "static",
            render = "minimal",
            background_colour = "Normal",
            -- top_down = false,
        }
    end,
}
