local custom = require "custom"
local opts = {
    delay = function(ctx)
        return ctx.plugin and 0 or 350
    end,
    plugins = {
        marks = true,
        presets = {
            windows = false,
            z = false,
            g = true,
        },
    },
    popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
    },
    win = {
        border = custom.border, -- none, single, double, shadow
    },
    layout = {
        height = { min = 20, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>", "require" },
    show_help = true,
    disable = {
        trigger = function(ctx)
            if ctx.keys == "`" then
                return true
            end
        end,
    },
}

return {
    "folke/which-key.nvim",
    event = { "BufNewFile", "BufReadPre" },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
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
