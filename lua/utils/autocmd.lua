-- set no comment in next line
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "set formatoptions-=ro",
})

-- set wrap only for markdown, typst and Avante
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        local ft = { "markdown", "typst", "Avante" }
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
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- customize VeryLazy load
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local function _trigger()
            vim.api.nvim_exec_autocmds("User", { pattern = "AfterLoad" })
        end

        if vim.bo.filetype == "snacks_dashboard" then
            vim.api.nvim_create_autocmd("BufRead", {
                once = true,
                callback = _trigger,
            })
        else
            _trigger()
        end
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd "checktime"
        end
    end,
})

-- fix select mode diagnostic
vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("diag_in_select", { clear = true }),
    pattern = "*:s",
    callback = function()
        vim.diagnostic.enable(false)
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("diag_in_select", { clear = false }),
    pattern = "[is]:n",
    callback = function()
        vim.diagnostic.enable()
    end,
})

-- fix padding on terminal
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
        io.write "\027]111\027\\"
    end,
})

local view_group = vim.api.nvim_create_augroup("auto_view", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
    desc = "Save view with mkview for real files",
    group = view_group,
    callback = function(args)
        if vim.b[args.buf].view_activated then
            vim.cmd.mkview { mods = { emsg_silent = true } }
        end
    end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
    desc = "Try to load file view if available and enable view saving for real files",
    group = view_group,
    callback = function(args)
        if not vim.b[args.buf].view_activated then
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
            local ignore_filetypes = { "gitcommit", "gitrebase", "hgcommit" }
            if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
                vim.b[args.buf].view_activated = true
                vim.cmd.loadview { mods = { emsg_silent = true } }
            end
        end
    end,
})
vim.api.nvim_create_autocmd("SessionLoadPost", {
    group = view_group,
    callback = function()
        vim.cmd.loadview { mods = { emsg_silent = true } }
    end,
})
