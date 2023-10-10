--包导入
require('keymap')
require('plugins')

-- 全局设置
vim.g.mapleader = ' '


-- 全局插件
require('leap').add_default_mappings()
-- require('surround').setup()

if vim.g.vscode then
    --仅用于vscode的插件
    vim.opt.timeoutlen = 500
    vim.opt.clipboard = 'unnamedplus' -- use system clipboar
else
    -- 仅用于neovim的插件
    require('option')
    require('lsp')
    require('colorscheme')
    require('nvim-autopairs').setup()
    require('lualine').setup()
    require('nvim-tree').setup({ -- 关闭文件时自动关闭
        -- auto_close = true,
        -- 不显示 git 状态图标
        git = {
            enable = false
        },
        require 'nvim-treesitter.configs'.setup {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        require('toggleterm').setup {
            size = 10,
            open_mapping = [[<A-q>]],
            direction = 'float',
            cmd = 'powershell -NoLogo',
            start_in_insert = true,
            shell = 'pwsh.exe',
            float_opts = {
                autochdir = true,
                border = 'curved',
                width = math.ceil(vim.o.columns * 0.8),
                height = math.ceil(vim.o.columns * 0.2)
            }
        }
    })
    require('tabout').setup {
        tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,            -- shift content if tab out is not possible
        act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>',  -- reverse shift default action,
        enable_backwards = true,      -- well ...
        completion = true,            -- if the tabkey is used in a completion pum
        tabouts = {
            { open = "'", close = "'" },
            { open = '"', close = '"' },
            { open = '`', close = '`' },
            { open = '(', close = ')' },
            { open = '[', close = ']' },
            { open = '{', close = '}' }
        }
    }
end
