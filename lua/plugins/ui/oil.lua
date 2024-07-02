---@diagnostic disable: param-type-mismatch
local custom = require "custom"
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    init = function()
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("lazy").load { plugins = { "oil.nvim" } }
            end
        end
        if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
            vim.api.nvim_create_autocmd("BufNew", {
                callback = function()
                    if vim.fn.isdirectory(vim.fn.expand "<afile>") == 1 then
                        require("lazy").load { plugins = { "oil.nvim" } }
                        return true
                    end
                end,
            })
        end
    end,

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
