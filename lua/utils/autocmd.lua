-- set no comment in next line
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "set formatoptions-=ro",
})

-- set wrap only for markdown
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        local ft = { "markdown", "typst" }
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

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd "checktime"
        end
    end,
})

-- bigfile optimize
vim.filetype.add {
    pattern = {
        [".*"] = {
            function(path, buf)
                return vim.bo[buf]
                        and vim.bo[buf].filetype ~= "bigfile"
                        and path
                        and vim.fn.getfsize(path) > vim.g.bigfile_size
                        and "bigfile"
                    or nil
            end,
        },
    },
}

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("bigfile", { clear = true }),
    pattern = "bigfile",
    callback = function(ev)
        vim.b.minianimate_disable = true
        vim.schedule(function()
            vim.bo[ev.buf].syntax = vim.filetype.match { buf = ev.buf } or ""
        end)
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
