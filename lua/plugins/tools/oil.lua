local custom = require "custom"
return {
    "stevearc/oil.nvim",
    -- enabled = false,
    keys = {
        {
            "-",
            function()
                if vim.bo.filetype ~= "minifiles" then
                    require("oil").open()
                end
            end,
            desc = "Open parent directory",
        },
        ["<Space>"] = "actions.select",
        ["L"] = "actions.select",
        ["H"] = "actions.parent",
    },
    opts = {
        default_file_explorer = true,
        columns = {
            -- "size",
            -- "mtime",
            "icon",
        },
        view_options = {
            show_hidden = true,
        },
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
            ["~"] = "actions.tcd",
            ["L"] = "actions.select",
            ["H"] = "actions.parent",
        },
    },
}
