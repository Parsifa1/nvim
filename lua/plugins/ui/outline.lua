local custom = require "custom"

return {
    "hedyhli/outline.nvim",
    opts = {
        preview_window = {
            border = custom.border,
            live = true,
        },
        symbols = {
            icon_source = "lspkind",
        },
    },
}
