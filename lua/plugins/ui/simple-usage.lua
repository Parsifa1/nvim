local function h(name)
    return vim.api.nvim_get_hl(0, { name = name })
end

-- hl-groups can have any name
vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, italic = true })
local function text_format(symbol)
    local res = {}

    if symbol.references then
        local usage = symbol.references <= 1 and "usage" or "usages"
        local num = symbol.references == 0 and "no" or symbol.references
        table.insert(res, { "󰌹  ", "SymbolUsageRef" })
        table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
    end

    if symbol.definition then
        if #res > 0 then
            table.insert(res, { " ", "NonText" })
        end
        table.insert(res, { "󰳽  ", "SymbolUsageDef" })
        table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
    end

    if symbol.implementation then
        if #res > 0 then
            table.insert(res, { " ", "NonText" })
        end
        table.insert(res, { "󰡱  ", "SymbolUsageImpl" })
        table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
    end

    return res
end

return {
    "Wansmer/symbol-usage.nvim",
    enabled = false,
    event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
        require("symbol-usage").setup {
            text_format = text_format,
        }
    end,
}
