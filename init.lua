vim.g.mapleader = ' '
--包导入
require('keymap')
require('plugins')
require('option')
if vim.g.vscode then
    vim.opt.timeoutlen = 1000
else
    require('colorscheme')
    require('lsp')
end
require('leap').add_default_mappings()
-- require('config.nvim-cmp')
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

require('lualine').setup()
require('nvim-tree').setup({ -- 关闭文件时自动关闭
    -- auto_close = true,
    -- 不显示 git 状态图标
    git = {
        enable = false
    }
})
require("toggleterm").setup {
    size = 10,
    open_mapping = [[<A-q>]],
    direction = 'float',
    cmd = "powershell -NoLogo",
    start_in_insert = true,
    shell = "pwsh.exe",
    float_opts = {
        autochdir = true,
        border = "curved",
        width = math.ceil(vim.o.columns * 0.8),
        height = math.ceil(vim.o.columns * 0.2)
    }
}
