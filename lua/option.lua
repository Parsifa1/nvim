-- colorscheme
vim.opt.background = "dark"
vim.cmd("colorscheme " .. "gruvbox-material")

-- close curdir
vim.opt.viewoptions = "cursor,folds"

-- sessionoptions
vim.opt.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"

-- normal setting
vim.g.copilot_assume_mapped = true
vim.g.copilot_proxy = "http://127.0.0.1:7891"
vim.opt.shortmess = vim.o.shortmess .. "a"
-- vim.opt.clipboard = "unnamedplus" -- use system clipboar
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in nvim

-- tab
vim.opt.tabstop = 4 -- number of visual spaces per tab
-- vim.opt.sofbstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- ui config
vim.opt.number = true -- add numbers to each line on the left side
vim.opt.relativenumber = true --show relative number
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.termguicolors = true -- enabl 24-bit rgb color in the tui
vim.opt.list = false
vim.opt.signcolumn = "yes"
-- vim.wo.wrap = true
vim.opt.fillchars = { eob = " " } -- close eob fillchars

-- searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

-- indentation
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)

-- asyncrun setting
vim.g.asyncrun_open = 6

-- no fold
vim.opt.foldlevel = 99

-- set statusline && mode
vim.opt.statusline = " "
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.showmode = false

-- close node && perl
vim.g["loaded_node_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy "+",
        ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste "+",
        ["*"] = require("vim.ui.clipboard.osc52").paste "*",
    },
}

if vim.g.neovide then
    vim.g.clipboard = false
    vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<C-v>", '<ESC>"+pa') -- Paste insert mode
end

-- import utils
require "utils.autocmd"
require "utils.highlight"
require "utils.floaterm"
