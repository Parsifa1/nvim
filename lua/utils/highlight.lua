-- buitin highlight
-- visual select
vim.api.nvim_set_hl(0, "visual", { reverse = true })
-- float
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
-- StatusLine
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "StatusLineTermNC", { link = "StatusLine" })
-- left symboline
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
-- cursorline
vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
-- winbar
vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
-- diagnostic
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#878787" })
vim.api.nvim_set_hl(0, "VirtualTextHint", { link = "DiagnosticHint" })
vim.api.nvim_set_hl(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "VirtualTextWarning", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "VirtualTextError", { link = "DiagnosticError" })

-- plugin hightlight
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#cccccc", bg = "#668aab" })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#cccccc", bg = "#a96ca5" })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#cccccc", bg = "#c9826b" })
