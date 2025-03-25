local set_hl = vim.api.nvim_set_hl
local get_hl = vim.api.nvim_get_hl
-- buitin highlight
-- visual select
-- set_hl(0, "Visual", { reverse = true })
-- float
set_hl(0, "NormalFloat", { bg = "NONE" })
set_hl(0, "FloatBorder", { bg = "NONE" })
-- StatusLine
set_hl(0, "StatusLine", { bg = "NONE" })
set_hl(0, "StatusLineNC", { link = "StatusLine" })
set_hl(0, "StatusLineTerm", { link = "StatusLine" })
set_hl(0, "StatusLineTermNC", { link = "StatusLine" })
-- left symboline
set_hl(0, "SignColumn", { bg = "NONE" })
set_hl(0, "FoldColumn", { bg = "NONE" })
-- cursorline
set_hl(0, "CursorLine", { bg = "NONE" })
set_hl(0, "CursorLineNr", { bg = "NONE" })
-- winbar
set_hl(0, "WinBar", { bg = "NONE" })
set_hl(0, "WinBarNC", { bg = "NONE" })
-- diagnostic
set_hl(0, "WinSeparator", { fg = "#878787" })
set_hl(0, "VirtualTextHint", { link = "DiagnosticHint" })
set_hl(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
set_hl(0, "VirtualTextWarning", { link = "DiagnosticWarn" })
set_hl(0, "VirtualTextError", { link = "DiagnosticError" })

-- plugin hightlight
-- Tabline
set_hl(0, "TabLineFill", { bg = "NONE" })
set_hl(0, "TabLineNone", { bg = "NONE" })
set_hl(0, "TabLineFocus", { fg = "#FCDCDD" })
-- Telescope
set_hl(0, "TelescopePreviewTitle", { fg = "#cccccc", bg = "#668aab" })
set_hl(0, "TelescopePromptTitle", { fg = "#cccccc", bg = "#a96ca5" })
set_hl(0, "TelescopeResultsTitle", { fg = "#cccccc", bg = "#c9826b" })
-- Snack
set_hl(0, "SnackScope", { fg = "#D3869B" })
-- Avante
set_hl(0, "AvanteSidebarWinSeparator", { link = "WinSeparator" })
local normal_bg = string.format("#%06x", get_hl(0, { name = "Normal" }).bg)
set_hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = normal_bg })
