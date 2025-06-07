local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- set no comment in next line
autocmd("FileType", {
    pattern = "*",
    command = "set formatoptions-=ro",
})

-- set wrap only for markdown, typst and codecompanion
autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        local ft = { "markdown", "typst", "codecompanion" }
        for _, v in ipairs(ft) do
            if vim.bo.filetype == v then
                vim.wo.wrap = true
                return
            end
            vim.wo.wrap = false
        end
    end,
})

-- highlight yank
autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- customize VeryLazy load
autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local function _trigger()
            vim.api.nvim_exec_autocmds("User", { pattern = "AfterLoad" })
        end
        if vim.bo.filetype == "snacks_dashboard" then
            autocmd("BufRead", {
                once = true,
                callback = _trigger,
            })
        else
            _trigger()
        end
    end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd "checktime"
        end
    end,
})

-- fix select mode diagnostic
local diag_in_select = augroup("diag_in_select", { clear = true })
autocmd("ModeChanged", {
    group = diag_in_select,
    pattern = "*:s",
    callback = function()
        vim.diagnostic.enable(false)
    end,
})
autocmd("ModeChanged", {
    group = diag_in_select,
    pattern = "[is]:n",
    callback = function()
        vim.diagnostic.enable()
    end,
})

-- fix padding on terminal
autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

autocmd("UILeave", {
    callback = function()
        io.write "\027]111\027\\"
    end,
})

-- auto trigger fold
local auto_view = augroup("auto_view", { clear = true })
autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
    desc = "Save view with mkview for real files",
    group = auto_view,
    callback = function(args)
        if vim.b[args.buf].view_activated then
            vim.cmd.mkview { mods = { emsg_silent = true } }
        end
    end,
})
autocmd("BufWinEnter", {
    desc = "Try to load file view if available and enable view saving for real files",
    group = auto_view,
    callback = function(args)
        if not vim.b[args.buf].view_activated then
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
            local ignore_filetypes = { "gitcommit", "gitrebase" }
            if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
                vim.b[args.buf].view_activated = true
                vim.cmd.loadview { mods = { emsg_silent = true } }
            end
        end
    end,
})

-- auto remove snippet on insert leave
autocmd("CursorMovedI", {
    pattern = "*",
    desc = "Forget the current snippet when leaving the insert mode",
    callback = function(ev)
        local ls = require "luasnip"
        if not ls.session or not ls.session.current_nodes[ev.buf] or ls.session.jump_active then
            return
        end
        local current_node = ls.session.current_nodes[ev.buf]
        local current_start, current_end = current_node:get_buf_position()
        current_start[1] = current_start[1] + 1 -- (1, 0) indexed
        current_end[1] = current_end[1] + 1 -- (1, 0) indexed
        local cursor = vim.api.nvim_win_get_cursor(0)
        if
            cursor[1] < current_start[1]
            or cursor[1] > current_end[1]
            or cursor[2] < current_start[2]
            or cursor[2] > current_end[2]
        then
            ls.unlink_current()
        end
    end,
})
