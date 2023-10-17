-- local telescope = require "telescope"

local function flash(prompt_bufnr)
    require("flash").jump {
        pattern = "^",
        label = { after = { 0, 0 } },
        search = {
            mode = "search",
            exclude = {
                function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                end,
            },
        },
        action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
        end,
    }
end
local opts = {
    defaults = {
        mappings = {
            n = { s = flash },
            i = { ["<c-s>"] = flash },
        },
        prompt_prefix = " ",
        selection_caret = " ",
    },
    pickers = {
        find_files = {
            theme = "ivy",
        },
        oldfiles = {
            theme = "ivy",
        },
    },
    extensions = {
        live_grep_args = {
            theme = "dropdown",
        },
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
}



return {

    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.4',
    dependencies = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
        { "nvim-telescope/telescope-dap.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
    },
    opts = opts
}
