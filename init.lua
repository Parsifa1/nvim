--全局设定
require('keymap')
require('plugins')
require('option')

-- 全局插件
require('leap').add_default_mappings()

if vim.g.vscode then
    --仅用于vscode的设置
else
    -- 仅用于neovim的设置
    vim.o.shortmess = vim.o.shortmess .. "A"


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
