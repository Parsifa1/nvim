local custom = require "custom"

return {
    "hedyhli/outline.nvim",
    -- event = "VeryLazy",
    keys = {
        { "<leader>a", "<Cmd>Outline<CR>", desc = "Outline" },
    },
    cmd = "Outline",
    opts = {
        preview_window = {
            border = custom.border,
            live = true,
        },
        symbols = {
            icon_source = custom.icons.vsckind,
        },
    },
}
