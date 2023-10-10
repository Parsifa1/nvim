vim.g.mapleader = '<Space>'
--全局设定
require('keymap')
require('plugins')
require('option')

-- 全局插件
require('leap').add_default_mappings()

if vim.g.vscode then
    --仅用于vscode的插件
else
    -- 仅用于neovim的插件
    require('nvim-autopairs').setup()
    require('lualine').setup()
    require('lsp')
    require('colorscheme')
    require('config.tabout')
    require('config.tree')
    require('config.treesitter')
    require('config.toggleterm')
    require('config.bufferline')
end
