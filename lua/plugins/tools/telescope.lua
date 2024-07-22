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
                ["zh"] = "select_horizontal",
                ["zv"] = "select_vertical",
                ["<A-q>"] = "close",
                ["<C-s>"] = flash,
                ["<C-f>"] = "to_fuzzy_refine",
            },
            i = {
                ["<A-q>"] = "close",
                ["<C-s>"] = flash,
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-f>"] = "to_fuzzy_refine",
            },
        },
        prompt_prefix = "  ",
        selection_caret = "  ",
        color_devicons = true,
    },
    pickers = {
        find_files = {
            find_command = {
                "fd",
                "-H",
                "-I",
                "--exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs,.cache,.ghcup,.conda,.rustup,.cargo,.local}",
                "--strip-cwd-prefix",
            },
            theme = "ivy",
        },
        oldfiles = {
            theme = "ivy",
        },
        git_files = {
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
            path_display = { "smart" },
            ignore_current_buffer = true,
            previewer = false,
            mappings = {
                n = { ["dd"] = "delete_buffer" },
            },
            initial_mode = "normal",
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
    {
        "benfowler/telescope-luasnip.nvim",
        cmd = "Telescope luasnip",
        keys = { { "<leader>ts", "<cmd>Telescope luasnip theme=ivy<CR>", desc = "telescope luasnip" } },
        config = function()
            require("telescope").load_extension "luasnip"
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        event = { "CursorHold", "CursorHoldI" },
        cmd = "Telescope",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-lua/popup.nvim",
        },
        keys = {
            -- { "<leader>r", "<cmd>Telescope oldfiles<CR>", desc = "recent files" },
            { "<leader>w", "<cmd>Telescope live_grep<CR>", desc = "find words" },
            { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "telescope buffers" },
            { "<Tab><Tab>", "<cmd>Telescope buffers<CR>", desc = "buffers" },
            { "<leader>tc", "<cmd>Telescope commands<CR>", desc = "telescope commands" },
            { "<leader>tk", "<cmd>Telescope keymaps<CR>", desc = "telescope keymaps" },
            { "<leader>tl", "<cmd>Telescope highlights<CR>", desc = "telescope highlights" },
            { "<leader>th", "<cmd>Telescope help_tags<CR>", desc = "telescope highlights" },
        },
        opts = opts,
        config = function()
            require("telescope").setup(opts)
            require("telescope").load_extension "fzf"
        end,
    },
}
