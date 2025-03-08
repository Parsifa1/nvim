---@diagnostic disable: assign-type-mismatch
return {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    init = function()
        local set_foldcolumn_for_file = vim.api.nvim_create_augroup("set_foldcolumn_for_file", {
            clear = true,
        })
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = set_foldcolumn_for_file,
            callback = function()
                vim.wo.foldcolumn = vim.bo.buftype == "" and "1" or "0"
            end,
        })
        vim.api.nvim_create_autocmd("OptionSet", {
            group = set_foldcolumn_for_file,
            pattern = "buftype",
            callback = function()
                vim.wo.foldcolumn = vim.bo.buftype == "" and "1" or "0"
            end,
        })
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function()
        -- 虚拟图标
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (" %d "):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
        end

        -- 忽略特定文件类型
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "leetcode.nvim", "lazy", "snacks_dashboard" },
            callback = function()
                require("ufo").detach()
                vim.opt_local.foldenable = false
                vim.opt_local.foldcolumn = "0"
            end,
        })

        vim.keymap.set("n", "zn", require("ufo").openAllFolds)
        vim.keymap.set("n", "zm", require("ufo").closeAllFolds)

        ---@diagnostic disable-next-line: missing-fields
        require("ufo").setup {
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                c = { "comment", "region" },
            },
            fold_virt_text_handler = handler,
        }
    end,
}
