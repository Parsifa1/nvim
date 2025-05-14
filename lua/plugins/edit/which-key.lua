local custom = require "custom"
local opts = {
    show_help = false,
    win = { border = custom.border },
    plugins = { presets = { z = true } },
    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,
    defer = function(ctx)
        return ctx.keys == "`" or ctx.mode == "V" or ctx.mode == "<C-V>" or ctx.mode == "v"
    end,
    replace = {
        desc = {
            { "<Plug>%((.*)%)", "%1" },
            { "^%+", "" },
            { "<[cC]md>", "" },
            { "<[cC][rR]>", "" },
            { "<[sS]ilent>", "" },
            { "^lua%s+", "" },
            { "^call%s+", "" },
            { "^:%s*", "" },
        },
    },
}

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        require("which-key").setup(opts)
        require("which-key").add {
            { "<leader>c", group = "Code Operations" },
            { "<leader>g", group = "Git" },
            { "<leader>s", group = "Chore" },
            { "<leader>t", group = "Telescope" },
            { "<leader>d", group = "Dap" },
            { "<leader>l", group = "Latex" },
        }
    end,
}
