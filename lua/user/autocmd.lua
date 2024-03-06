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

-- auto load fold
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "lua", "py", "cpp", "rust" },
--     callback = function()
--         vim.cmd "mkview"
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "lua", "python", "cpp", "rust" },
--     callback = function()
--         vim.cmd "silent! loadview"
--     end,
-- })

