local custom = require "custom"
return {
    "folke/which-key.nvim",
    event = "BufReadPre",
    cond = vim.bo.filetype ~= "alpha",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        plugins = {
            presets = {
                windows = false,
                z = true,
                g = true,
            },
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = custom.border, -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 },
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 },
            width = { min = 20, max = 50 },
            spacing = 3,
            align = "left",
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>", "require" },
        show_help = true,
        triggers = "auto",
        triggers_blacklist = {
            i = { "j", "k" },
            v = { "j", "k" },
        },
    },
}
