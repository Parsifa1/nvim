---@diagnostic disable: unused-local
return {
    "folke/edgy.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
        bottom = {
            {
                ft = "toggleterm",
                title = "Terminal",
                size = { height = 0.4 },
                -- exclude floating windows
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
        },
    },
}
