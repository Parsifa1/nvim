local get_root = require("utils.gitutils").get_root
local function dirs()
    ---@type table<string, boolean>
    local seen = {}
    ---@type table<string, boolean>
    local session_dirs = {}
    for _, item in ipairs(require("session_manager.utils").get_sessions()) do
        session_dirs[item.dir.filename:gsub("\\", "/")] = true
    end
    local filt_seen = function(dir)
        if seen[dir] then
            return false
        end
        seen[dir] = true
        return true
    end

    ---@param file string
    ---@return string|nil
    local function map_file(file)
        if not vim.uv.fs_stat(file) then
            return nil
        end
        for session_dir in pairs(session_dirs) do
            local session_simbol = file:sub(session_dir:len() + 1, session_dir:len() + 1)
            local git_root = get_root(file)
            if vim.startswith(file, session_dir) and session_simbol == "/" then
                return session_dir
            end
            if git_root and vim.startswith(file, git_root) then
                return git_root
            end
        end
        return vim.fs.dirname(file)
    end

    local map_winpath = function(path)
        if path:match "^[A-Z]:/" then
            return path:gsub("/", "\\")
        end
        return path
    end

    ---@type string[]
    local ret = vim.tbl_map(
        map_winpath,
        vim.tbl_filter(filt_seen, vim.tbl_map(map_file, vim.tbl_map(vim.fs.normalize, vim.v.oldfiles)))
    )

    return ret
end

local header = [[
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡤⠤⢤⡤⠴⢤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⣞⣋⡁⣠⡤⢴⣋⡠⢄⣀⠀⠈⠛⠷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⡿⣟⠽⠛⢛⡜⣱⡞⠉⢮⡉⠑⢮⣑⢦⡀⠀⠈⠻⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡏⢘⠁⢀⣴⡟⢁⡇⡇⠀⠈⢿⣦⠀⠙⣷⡙⢦⡀⠀⠸⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣏⠔⠁⣠⠊⣾⡇⢸⠁⣇⠀⠀⠘⣧⢃⠀⠘⣷⠈⢻⣆⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⢟⡏⠀⡰⢣⢾⣿⠀⢸⠀⣿⠀⠀⠀⢿⡞⡆⠀⣿⣇⠈⢻⣆⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠇⡾⠀⢰⣷⠧⢺⢹⠀⢸⡀⠸⡇⠀⠀⠘⡇⢡⠀⢸⣽⡀⠈⣿⡀⣿⡀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣼⣻⠀⣿⠃⠀⠀⣿⡆⢸⣧⠀⢻⡉⠙⠒⢷⣸⠀⢸⣌⣧⡀⣾⣧⣯⣗⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⡇⢀⣯⣷⣶⣶⡿⣷⡘⣿⣆⡈⢿⣤⣆⠸⢸⠂⠀⣿⣼⣽⣿⡇⡏⢻⣇⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣧⠈⡿⡸⣿⣿⣿⠍⠛⠛⠉⢹⣿⣿⣿⢿⣿⣀⣠⣷⣿⢿⣵⣤⡇⢠⣿⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⣿⣿⣷⣽⣔⠙⠒⠋⠀⠀⠀⠀⠀⠿⣉⣿⠃⡝⢡⣿⣿⡿⣸⣿⣄⣰⣿⠋⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠿⢛⡿⢹⣧⢸⢻⡏⠁⠀⠀⠀⠀⠀⠀⠀⢠⠀⣠⣾⣷⣿⢿⣿⣧⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⣠⣾⠁⣸⡇⡿⡿⣷⣄⠀⠀⠀⢠⡀⠀⠀⠀⠀⠀⣸⣇⡞⣿⣿⣿⡙⣿⢸⣿⢿⢿⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⢰⣿⡿⢻⢞⡽⣱⡾⣼⣿⣿⣿⣦⡀⠀⠀⠀⠀⣀⡤⠀⣟⡟⢠⣇⣻⡏⣇⣿⡀⣿⢾⣿⠀⠀⠀⠀⠀⠀
    ⠀⠀⢀⣴⠟⡱⠀⢀⣾⢟⣿⣿⣿⣿⣿⡟⠛⠉⢩⠿⠛⠀⠀⢀⣼⡟⢡⣾⣿⠟⢿⣿⣆⢹⣿⢸⣿⠈⣿⡄⠀⠀⠀⠀
    ⠀⡴⢻⣋⡞⡤⢶⣿⠏⣾⣿⣿⣿⣿⡿⠀⠀⢀⣿⣿⣷⣤⣠⣾⡿⣠⣿⡟⠁⣀⣠⣽⣿⡄⠈⠻⢿⡀⠙⣿⢦⡀⠀⠀
    ⢰⣧⡿⣿⠀⢠⣾⡇⣸⣿⡟⢡⣯⡿⣇⠀⠀⣸⠇⠀⠹⣿⣿⣿⣠⣿⣿⣷⣾⣿⣿⢿⢿⣿⣆⢣⠀⢻⣤⡸⡌⢿⡄⠀
    ⠸⣿⣧⢿⠷⣎⣿⠁⣿⡿⠃⠈⣿⢷⣿⡀⠀⡟⠀⣠⠞⣵⡿⢡⣿⣿⣿⣿⢛⣿⣷⣧⡞⠀⢹⣼⡇⢹⢿⡿⣿⠀⢿⡄
    ⠀⠀⢹⡞⣤⣿⣿⣆⣿⣷⣴⣾⠁⠈⢿⣧⢠⣧⠞⠁⠀⣿⠇⢸⡿⠟⢡⡇⣸⡟⣿⣿⣿⠀⠀⢿⡇⠰⣿⡇⢹⠀⣸⡇
    ⠀⠀⠘⠛⠙⣽⣿⣿⠟⢻⡾⠛⢯⡀⣼⣿⣾⣯⣶⣾⣿⠿⣶⣽⡦⠀⡜⢠⡟⠹⢿⣿⠈⣇⠀⢸⣧⣸⣿⠁⣸⣴⡿⠁
    ⠀⠀⠀⠀⣴⠟⣿⢋⣤⣾⠃⠀⠀⣹⢟⣿⠉⣹⣿⣍⡁⠀⠀⣀⡥⠞⠁⠈⠀⢧⠀⠻⠂⠙⠀⠀⢹⡗⠃⠈⠉⠈⠁⠀
    ⠀⠀⠀⠀⠀⣸⣿⣿⣫⠇⠀⣠⠞⣱⠛⣿⣿⢿⠹⡇⠀⣯⠉⠁⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⠀⠀⠈⣿⠀⠀⠀⠀⠀⠀
]]

---@type snacks.picker.layout.Config
local ivy = {
    layout = {
        box = "horizontal",
        row = -1,
        height = 26,
        backdrop = false,
        {
            { win = "input", height = 1, border = "rounded" },
            { win = "list", border = "rounded" },
            box = "vertical",
            border = "none",
            title = "{title} {live} {flags}",
        },
        { win = "preview", title = "{preview}", border = "rounded", width = 0.5 },
    },
}

---@type snacks.picker.layout.Config
local select = {
    layout = {
        { border = "bottom", height = 1, win = "input" },
        { border = "none", win = "list" },
        { border = "top", height = 0.4, title = "{preview}", win = "preview" },
        height = 0.4,
        width = 0.5,
        min_height = 12,
        border = "rounded",
        box = "vertical",
        title = "{title}",
        title_pos = "center",
        backdrop = false,
    },
    preview = nil,
}

local function keys()
    local function snack(name)
        return ("<cmd>lua Snacks.picker." .. name .. "()<CR>")
    end
    if vim.uv.os_uname().sysname == "Windows_NT" then
        return {
            { "<leader>w", snack "grep", desc = "live grep" },
            { "<leader>f", snack "smart", desc = "find files" },
            { "<tab><tab>", snack "buffers", desc = "buffers" },
            { "<leader>th", snack "help", desc = "help picker" },
            { "<leader>r", snack "recent", desc = "recent files" },
            { "<leader>tk", snack "keymaps", desc = "keymaps picker" },
            { "<leader>tc", snack "commands", desc = "commands picker" },
            { "<leader>tl", snack "highlights", desc = "highlights picker" },
            { "<leader>N", "<cmd>lua Snacks.notifier.show_history()<CR>", desc = "buffers" },
        }
    else
        return {
            { "<tab><tab>", snack "buffers", desc = "buffers" },
            { "<leader>tp", snack "lazy", desc = "lazy packers" },
            { "<leader>N", "<cmd>lua Snacks.notifier.show_history()<CR>", desc = "buffers" },
        }
    end
end

return {
    "folke/snacks.nvim",
    lazy = false,
    keys = keys(),
    priority = 1000,
    ---@type snacks.Config
    opts = {
        notifier = {},
        quickfile = {},
        words = { debounce = 100 },
        styles = { notification_history = { backdrop = false } },
        dashboard = {
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find file", action = "<cmd>FzfLua files<CR>" },
                    { icon = " ", key = "r", desc = "Recently used files", action = "<cmd>FzfLua oldfiles<CR>" },
                    { icon = "󰂖 ", key = "p", desc = "Plugins", action = "<cmd>Lazy<CR>" },
                    { icon = "󰅚 ", key = "q", desc = "Quit Neovim", action = "<cmd>qa<CR>" },
                },
                pick = function(item, arg)
                    require("fzf-lua")[item](arg)
                end,
            },
            sections = {
                { text = { { header, hl = "Include" } }, align = "center" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                {
                    icon = " ",
                    title = "Projects",
                    section = "projects",
                    dirs = dirs,
                    limit = 4,
                    indent = 2,
                    padding = 1,
                },
                { icon = "⚡️ ", section = "startup", hl = "Keyword" },
            },
        },
        bigfile = {
            enabled = true,
            notify = false, -- show notification when big file detected
            line_length = 1000,
            size = 1024 * 1024 * 1.5, -- 1.5MB
            setup = function(ctx)
                if vim.fn.exists ":NoMatchParen" ~= 0 then
                    vim.cmd [[NoMatchParen]]
                end
                require("snacks").util.wo(0, { foldmethod = "manual", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(ctx.buf) then
                        vim.bo[ctx.buf].syntax = ctx.ft
                    end
                end)
            end,
        },
        picker = {
            ui_select = false,
            layouts = { ivy = ivy, select = select },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                        ["<C-/>"] = { "toggle_help_input", mode = { "i" } },
                    },
                },
            },
            layout = {
                preset = function(type)
                    if type == "smart" or type == "files" or type == "recent" then
                        return "ivy"
                    elseif type == "buffers" then
                        return "dropdown"
                    else
                        return "default"
                    end
                end,
                layout = {
                    backdrop = false,
                },
            },
            sources = {
                buffers = {
                    current = false,
                    on_show = function()
                        vim.cmd.stopinsert()
                    end,
                    win = {
                        input = {
                            keys = {
                                ["dd"] = { "bufdelete", mode = { "n" } },
                            },
                        },
                    },
                },
            },
        },
        image = {
            doc = {
                inline = false,
                float = vim.fn.hostname() ~= ("nixos" or "debian"),
            },
            convert = {
                math = {
                    font_size = "large",
                },
            },
        },
    },
}
