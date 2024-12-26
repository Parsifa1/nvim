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

    local map_file = function(file)
        if not vim.uv.fs_stat(file) then
            return nil
        end
        for session_dir in pairs(session_dirs) do
            if vim.startswith(file, session_dir) then
                return session_dir
            end
        end
        return (vim.fn.fnamemodify(file, ":h"))
    end

    local map_winpath = function(path)
        if path:match "^[A-Z]:/" then
            return path:gsub("/", "\\")
        end
        return path
    end

    ---@type string[]
    local normalized_files = vim.tbl_map(vim.fs.normalize, vim.v.oldfiles)

    ---@type string[]
    local paths = vim.tbl_filter(filt_seen, vim.tbl_map(map_file, normalized_files))

    ---@type string[]
    local ret = (vim.tbl_map(map_winpath, paths))

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

return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        quickfile = {},
        dashboard = {
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find file", action = "<cmd>FzfLua files<CR>" },
                    { icon = " ", key = "r", desc = "Recently used files", action = "<cmd>FzfLua oldfiles<CR>" },
                    { icon = "󰂖 ", key = "p", desc = "Plugins", action = "<cmd>Lazy<CR>" },
                    { icon = "󰅚 ", key = "q", desc = "Quit Neovim", action = "<cmd>qa<CR>" },
                },
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
                { section = "startup", hl = "Keyword" },
            },
        },
        words = {
            debounce = 100,
        },
        bigfile = {
            enabled = true,
            notify = true, -- show notification when big file detected
            size = 1024 * 1024 * 1.5, -- 1.5MB
            setup = function(ctx)
                vim.cmd [[NoMatchParen]]
                require("snacks").util.wo(0, { foldmethod = "manual", conceallevel = 0 })
                vim.b.minianimate_disable = true
                vim.schedule(function()
                    vim.bo[ctx.buf].syntax = ctx.ft
                end)
            end,
        },
        indent = {
            indent = {
                enabled = true,
                char = "│",
            },
            scope = {
                hl = "SnackScope",
            },
            filter = function(buf)
                return vim.g.snacks_indent ~= false
                    and vim.b[buf].snacks_indent ~= false
                    and vim.bo[buf].buftype == ""
                    and vim.bo[buf].filetype ~= "oil"
                    and vim.bo[buf].filetype ~= ""
            end,
        },
    },
}
