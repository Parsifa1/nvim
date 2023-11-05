---@diagnostic disable missing-fields
return {
    'rcarriga/nvim-notify',
    lazy = true,
    event = "VeryLazy",
    config = function()
        local notify = require("notify")
        notify.setup({
            stages = "fade_in_slide_out",
            render = "wrapped-compact",
            background_colour = "Normal",
            top_down = false,
        })
    end,
}
