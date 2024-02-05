return {
    "EdenEast/nightfox.nvim",
    config = function()
        -- local C = require("nightfox.palette").load "nordfox"
        -- local CmpText = "#ffffff"
        require("nightfox").setup {
            options = {
                transparent = not vim.g.neovide,
                modules = { cmp = { enable = true } },
            },
            groups = {
                all = {
                    NormalFloat = { fg = "fg1", bg = "NONE" },
                    WinSeparator = { fg = "#7c7c7c", bg = "NONE" },
                    -- for cmp
                    -- CmpItemKindSnippet = { fg = CmpText, bg = C.green },
                    -- CmpItemKindKeyword = { fg = CmpText, bg = C.red },
                    -- CmpItemKindText = { fg = CmpText, bg = C.orange },
                    -- CmpItemKindMethod = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindConstructor = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindFunction = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindFolder = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindModule = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindConstant = { fg = CmpText, bg = C.magenta },
                    -- CmpItemKindField = { fg = CmpText, bg = C.green },
                    -- CmpItemKindProperty = { fg = CmpText, bg = C.green },
                    -- CmpItemKindEnum = { fg = CmpText, bg = C.green },
                    -- CmpItemKindUnit = { fg = CmpText, bg = C.green },
                    -- CmpItemKindClass = { fg = CmpText, bg = C.yellow },
                    -- CmpItemKindVariable = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindFile = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindInterface = { fg = CmpText, bg = C.yellow },
                    -- CmpItemKindColor = { fg = CmpText, bg = C.red },
                    -- CmpItemKindReference = { fg = CmpText, bg = C.red },
                    -- CmpItemKindEnumMember = { fg = CmpText, bg = C.red },
                    -- CmpItemKindStruct = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindValue = { fg = CmpText, bg = C.pink },
                    -- CmpItemKindEvent = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindOperator = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindTypeParameter = { fg = CmpText, bg = C.blue },
                    -- CmpItemKindCopilot = { fg = CmpText, bg = C.green },
                },
            },
        }
    end,
}
