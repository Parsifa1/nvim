local custom = require "custom"
local opts = {
    show_help = true,
    win = { border = custom.border },
    plugins = { presets = { z = false } },
    layout = {
        height = { min = 20, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    delay = function(ctx)
        return ctx.plugin and 0 or 300
    end,
    defer = function(ctx)
        return ctx.keys == "`" or ctx.mode == "V" or ctx.mode == "<C-V>" or ctx.mode == "v"
    end,
}

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup(opts)
        require("which-key").add {
            { "<leader>c", group = "Code Operations" },
            { "<leader>g", group = "Git" },
            { "<leader>s", group = "chore" },
            { "<leader>t", group = "Telescope" },
        }
    end,
}
