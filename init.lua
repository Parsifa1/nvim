--全局设定
require('keymap')
require('plugin')
require('option')

-- 全局插件
-- require('leap').add_default_mappings()

if vim.g.vscode then
    --仅用于vscode的设置
elseif vim.g.neovide then
    vim.g.neovide_remember_window_size = true
else
    -- 仅用于neovim的设置
    vim.o.shortmess = vim.o.shortmess .. "A"

    -- require('colorscheme')
    -- require('lsp')
    -- require('nvim-autopairs').setup()
    -- require('lualine').setup()

    -- require('config.tabout')
    -- require('config.tree')
    -- require('config.treesitter')
    -- require('config.toggleterm')
    -- require('config.bufferline')
    -- require('config.compatitest')
    -- require('config.floaterm')
end
