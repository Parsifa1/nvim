if vim.g.vscode then
    vim.opt.timeoutlen = 500
    vim.opt.clipboard = "unnamedplus" -- use system clipboar
else
    vim.loader.enable()
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_proxy = "http://127.0.0.1:7891"
    vim.o.shortmess = vim.o.shortmess .. "a"
    vim.opt.clipboard = "unnamedplus" -- use system clipboard
    vim.opt.completeopt = { "menu", "menuone", "noselect" }
    vim.opt.mouse = "a"               -- allow the mouse to be used in nvim
    -- tab
    vim.opt.tabstop = 4               -- number of visual spaces per tab
    -- vim.opt.sofbstop = 4 -- number of spacesin tab when editing
    vim.opt.shiftwidth = 4            -- insert 4 spaces on a tab
    vim.opt.expandtab = true          -- tabs are spaces, mainly because of python
    -- ui config
    vim.opt.number = true             -- add numbers to each line on the left side
    vim.opt.relativenumber = true     --show relative number
    vim.opt.cursorline = true         -- highlight cursor line underneath the cursor horizontally
    vim.opt.splitbelow = true         -- open new vertical split bottom
    vim.opt.splitright = true         -- open new horizontal splits right
    vim.opt.termguicolors = true      -- enabl 24-bit rgb color in the tui
    vim.opt.list = false
    vim.opt.signcolumn = "yes"
    -- vim.opt.signcolumn = "number"
    vim.wo.wrap = false
    -- set highlight
    vim.api.nvim_set_hl(0, "visual", { reverse = true })
    -- searching
    vim.opt.incsearch = true  -- search as characters are entered
    vim.opt.hlsearch = false  -- do not highlight matches
    vim.opt.ignorecase = true -- ignore case in searches by default
    vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered
    -- indentation
    vim.opt.timeoutlen = 500  -- time to wait for a mapped sequence to complete (in milliseconds)
    -- asyncrun setting
    vim.g.asyncrun_open = 6
    -- no fold
    vim.opt.foldlevel = 99
    -- for neovide
    if vim.g.neovide then
        vim.o.guifont = "JetBrains_Mono,JetBrainsMono_Nerd_Font,LXGW_WenKai:h12"
        vim.g.clipboard = {
            name = 'win32yank-wsl',
            copy = {
                ['+'] = 'win32yank.exe -i --crlf',
                ['*'] = 'win32yank.exe -i --crlf',
            },
            paste = {
                ['+'] = 'win32yank.exe -o --lf',
                ['*'] = 'win32yank.exe -o --lf',
            },
            cache_enabled = 0,
        }
        vim.g.neovide_remember_window_size = true
        vim.g.neovide_theme = 'auto'
        vim.g.neovide_padding_left = 10
        vim.g.neovide_scroll_animation_length = 0.3
        vim.g.neovide_hide_mouse_when_typing = true
        vim.g.neovide_underline_stroke_scale = 0.9
        vim.g.neovide_padding_top = 10
        vim.g.neovide_padding_bottom = 5
        vim.g.neovide_padding_right = 10
        vim.keymap.set('v', '<C-c>', 'y')       -- Copy
        vim.keymap.set('n', '<C-v>', 'P')       -- Paste normal mode
        vim.keymap.set('v', '<C-v>', 'P')       -- Paste visual mode
        vim.keymap.set('c', '<C-v>', '<C-R>+')   -- Paste command mode
        vim.keymap.set('i', '<C-v>', '<ESC>lpli') -- Paste insert mode
    end
end

