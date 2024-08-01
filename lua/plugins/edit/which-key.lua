local custom = require "custom"
local opts = {
    -- preset = "helix",
    show_help = true,
    win = { border = custom.border },
    plugins = { presets = { z = true } },
    delay = function(ctx)
        return ctx.plugin and 0 or 200
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
            { "<leader>s", group = "Chore" },
            { "<leader>t", group = "Telescope" },
            { "<leader>d", group = "Dap"},
        }
    end,
}
