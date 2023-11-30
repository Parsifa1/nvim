local function flash(prompt_bufnr)
    require("flash").jump({
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
    })
end
local opts = {
    defaults = {
        mappings = {
            n = {
                s = flash,
                ["q"] = 'close',
            },
            i = {
                ["<A-q>"] = 'close',
                ["<c-s>"] = flash
            },
        },
        prompt_prefix = "  ",
        selection_caret = " ",
    },
    pickers = {
        find_files = {
            find_command = {
                "fd",
                "-H",
                "-I",
                "--exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs}",
                "--strip-cwd-prefix",
            },
            theme = "ivy",
        },
        oldfiles = {
            theme = "ivy",
        },
        live_grep = {
            theme = "ivy",
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

return {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.4",
    -- event = "VeryLazy",
    cmd = "Telescope",
    dependencies = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
    },
    opts = opts,
}

