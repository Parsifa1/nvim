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
        layout_config = {
            vertical = {
                width_padding = 0.05,
                height_padding = 1,
                preview_height = 0.5,
            },
            horizontal = {
                width_padding = 0.1,
                height_padding = 0.1,
                preview_height = 0.5,
                preview_width = 0.5,
            },
        },
        mappings = {
            n = {
                s = flash,
                ["q"] = "close",
                ["<A-q>"] = "close",
                ["zh"] = "select_horizontal",
                ["zv"] = "select_vertical",
            },
            i = {
                ["<A-q>"] = "close",
                ["<c-s>"] = flash,
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
            vimgrep_arguments = {
                "rg",
                "--no-heading",
                -- '--with-filename',
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
                "--glob", -- this flag allows you to hide exclude these files and folders from your search 👇
                "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock,.vscode-server,.virtualenvs}",
            },
            layout_strategy = "vertical",
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    ["dd"] = "delete_buffer",
                },
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        workspaces = {
            theme = "dropdown",
        },
    },
}
return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
    },
    opts = opts,
    config = function()
        require("telescope").setup(opts)
        require("telescope").load_extension "workspaces"
    end,
}
