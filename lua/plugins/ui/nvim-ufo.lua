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

local function customizeSelector(bufnr)
    local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match "UfoFallbackException" then
            return require("ufo").getFolds(providerName, bufnr)
        else
            return require("promise").reject(err)
        end
    end
    return require("ufo")
        .getFolds(bufnr, "lsp")
        :catch(function(err)
            return handleFallbackException(err, "treesitter")
        end)
        :catch(function(err)
            return handleFallbackException(err, "indent")
        end)
end

---@diagnostic disable: assign-type-mismatch
return {
    "kevinhwang91/nvim-ufo",
    event = { "BufNewFile", "BufRead" },
    dependencies = "kevinhwang91/promise-async",
    config = function()
        vim.keymap.set("n", "zn", require("ufo").openAllFolds)
        vim.keymap.set("n", "zm", require("ufo").closeAllFolds)

        local ftMap = { vim = "indent", snacks_dashboard = "" }
        require("ufo").setup {
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                c = { "comment", "region" },
            },
            fold_virt_text_handler = handler,
            provider_selector = function(_, filetype, _)
                return ftMap[filetype] or customizeSelector
            end,
        }
    end,
}
