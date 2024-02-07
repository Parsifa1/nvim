local custom = require "custom"

return {
    "hedyhli/outline.nvim",
    event = "VeryLazy",
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
