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

-- osc52
-- if vim.clipboard and vim.clipboard.osc52 then
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            vim.g.clipboard = {
                name = "OSC 52",
                copy = {
                    ["+"] = require("vim.ui.clipboard.osc52").copy "+",
                    ["*"] = require("vim.ui.clipboard.osc52").copy "*",
                },
                paste = {
                    ["+"] = require("vim.ui.clipboard.osc52").paste "+",
                    ["*"] = require("vim.ui.clipboard.osc52").paste "*",
                },
            }
        end,
    })
-- end
