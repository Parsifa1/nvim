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

local project_files = function()
    local is_inside_work_tree = {}
    local builtin = require "telescope.builtin"
    local option = {} -- define here if you want to define something

    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system "git rev-parse --is-inside-work-tree"
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        builtin.git_files(option)
    else
        builtin.find_files(option)
    end
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
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
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
            ignore_current_buffer = true,
            previewer = false,
            mappings = {
                n = {
                    ["dd"] = "delete_buffer",
                },
            },
            initial_mode = "normal",
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        workspaces = {
            theme = "dropdown",
            initial_mode = "normal",
        },
        undo = {
            initial_mode = "normal",
            mappings = {
                n = {
                    ["y"] = function(b)
                        return require("telescope-undo.actions").yank_additions(b)
                    end,
                    ["Y"] = function(b)
                        return require("telescope-undo.actions").yank_deletions(b)
                    end,
                    ["<CR>"] = function(b)
                        return require("telescope-undo.actions").restore(b)
                    end,
                },
            },
        },
    },
}
return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        lazy = true,
        build = "make",
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/popup.nvim",
            "benfowler/telescope-luasnip.nvim",
            "debugloop/telescope-undo.nvim",
        },
        keys = {
            { "<leader>f", project_files, desc = "find files" },
            { "<leader>r", "<cmd>Telescope oldfiles<CR>", desc = "recent files" },
            { "<leader>w", "<cmd>Telescope live_grep<CR>", desc = "find words" },
            { "<leader>b", "<cmd>Telescope buffers <CR>", desc = "telescope buffers" },
            { "<Tab><Tab>", "<cmd>Telescope buffers <CR>", desc = "buffers" },
            { "<leader><Tab>", "<cmd>Telescope workspaces theme=dropdown<CR><esc>", desc = "projects folder" },
            { "<leader>i", "<cmd>Telescope workspaces theme=dropdown<CR><esc>", desc = "projects folder" },
            { "<leader>u", "<cmd>Telescope undo<CR>", desc = "undo tree" },
            { "<leader>tc", "<cmd>Telescope commands<CR>", desc = "telescope commands" },
            { "<leader>tk", "<cmd>Telescope keymaps<CR>", desc = "telescope keymaps" },
        },
        opts = opts,
        config = function()
            require("telescope").setup(opts)
            require("telescope").load_extension "workspaces"
            require("telescope").load_extension "fzf"
            require("telescope").load_extension "undo"
        end,
    },
}
