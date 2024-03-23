return {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("notify").setup {
            stages = "static",
            render = "minimal",
            background_colour = "Normal",
            on_open = function(win)
                vim.api.nvim_win_set_config(win, { focusable = false })
            end,
            -- top_down = false,
        }
    end,
}
