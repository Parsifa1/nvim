local custom = require "custom"

---@type LazyPluginSpec
return {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        icons = { kinds = { symbols = custom.icons.kind_with_space } },
        sources = {
            path = {
                modified = function(sym)
                    return sym:merge {
                        name = sym.name .. " [+]",
                        name_hl = "DiffAdded",
                    }
                end,
            },
        },
    },
}
