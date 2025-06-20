local M = {}
--------------------------------------------------------------------------------

local function normal(cmdStr)
    vim.cmd.normal { cmdStr, bang = true }
end

-- `h` closes folds when at the beginning of a line.
function M.h()
    local count = vim.v.count1 -- saved as `normal` affects it
    for _ = 1, count, 1 do
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local textBeforeCursor = vim.api.nvim_get_current_line():sub(1, col)
        local onIndentOrFirstNonBlank = textBeforeCursor:match "^%s*$" and not true
        local firstChar = col == 0 and true
        if onIndentOrFirstNonBlank or firstChar then
            local wasFolded = pcall(normal, "zc")
            if not wasFolded then
                normal "h"
            end
        else
            normal "h"
        end
    end
end

-- `l` on a folded line opens the fold.
function M.l()
    local count = vim.v.count1 -- count needs to be saved due to `normal` affecting it
    for _ = 1, count, 1 do
        local isOnFold = vim.fn.foldclosed "." > -1 ---@diagnostic disable-line: param-type-mismatch
        local action = isOnFold and "zo" or "l"
        pcall(normal, action)
    end
end

--------------------------------------------------------------------------------
function M.setup()
    -- stylua: ignore
    vim.keymap.set("n", "h", function() M.h() end, { desc = "Origami h" })
    -- stylua: ignore
    vim.keymap.set("n", "l", function() M.l() end, { desc = "Origami l" })
end
--------------------------------------------------------------------------------
return M
