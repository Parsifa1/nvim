local custom = require "custom"
return {
    'stevearc/oil.nvim',
    event = "VeryLazy",
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        {
            "-",
            function()
                require("oil").open()
            end,
            desc = "Open parent directory",
        },
        ["<Space>"] = "actions.select",
    },
    opts = {
        skip_confirm_for_simple_edits = true,
        cleanup_delay_ms = false,
        float = {
            border = custom.border,
        },
        preview = {
            border = custom.border,
        },
        progress = {
            border = custom.border,
        },
        keymaps = {
            ["<Space>"] = "actions.select",
            ["<C-s>"] = "actions.select_split",
            ["<C-v>"] = "actions.select_vsplit",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd"
        },
    },
}
