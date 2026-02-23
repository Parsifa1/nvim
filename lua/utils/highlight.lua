local set_hl = function(...) vim.api.nvim_set_hl(0, ...) end
-- buitin highlight
-- float
vim.cmd.hi "NormalFloat guibg=NONE"
vim.cmd.hi "FLoatBorder guibg=NONE"
-- StatusLine
vim.cmd.hi "StatusLine guibg=NONE"
set_hl("StatusLineTerm", { link = "StatusLine" })
set_hl("StatusLineTermNC", { link = "StatusLine" })
-- left symboline
vim.cmd.hi "SignColumn guibg=NONE"
vim.cmd.hi "FoldColumn guibg=NONE"
-- cursorline
vim.cmd.hi "CursorLine guibg=NONE"
vim.cmd.hi "CursorLineNr guibg=NONE"
-- winbar
vim.cmd.hi "WinBar guibg=NONE"
vim.cmd.hi "WinBarNC guibg=NONE"
-- diff
set_hl("diffAdded", { link = "DiffAdd" })
set_hl("diffRemoved", { link = "DiffDelete" })
-- diagnostic
vim.cmd.hi "ErrorMsg cterm=bold gui=bold"
-- set_hl("WinSeparator", { fg = "#878787" })
set_hl("VirtualTextHint", { link = "DiagnosticHint" })
set_hl("VirtualTextInfo", { link = "DiagnosticInfo" })
set_hl("VirtualTextWarning", { link = "DiagnosticWarn" })
set_hl("VirtualTextError", { link = "DiagnosticError" })

-- plugin hightlight
-- Tabline
vim.cmd.hi "TabLineFill guibg=NONE"
-- Telescope
vim.cmd.hi "TelescopePreviewTitle guifg=#cccccc guibg=#668aab"
vim.cmd.hi "TelescopePromptTitle guifg=#cccccc guibg=#a96ca5"
vim.cmd.hi "TelescopeResultsTitle guifg=#cccccc guibg=#c9826b"
