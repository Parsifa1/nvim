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

-- dynamic show lualine
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        require("lualine").hide { place = { "tabline" }, unhide = false }
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        require("lualine").hide { place = { "tabline" }, unhide = true }
    end,
})
