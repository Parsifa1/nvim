return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        local gitsigns = require "gitsigns"
        -- local custom = require "custom"

        gitsigns.setup {
            signs = {
                add = { text = "┃" },
                change = { text = "┃" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "" },
                untracked = { text = "▏" },
            },
            signcolumn = true,
        }

        --test
        local function set_hl()
            vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "DiffText" })
            vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "DiffDelete" })

            vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "GitSignsAddLn" })
            vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { link = "GitSignsDeleteLn" })
            vim.api.nvim_set_hl(0, "GitSignsChangeInline", { link = "GitSignsChangeLn" })
        end

        set_hl()

        vim.api.nvim_create_autocmd("ColorScheme", {
            desc = "Set gitsigns highlights",
            callback = set_hl,
        })
    end,
}
