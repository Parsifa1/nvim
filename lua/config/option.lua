require "utils.autocmd"

-- colorscheme
vim.opt.background = "dark"
vim.cmd("colorscheme " .. "everforest")

-- close curdir
vim.opt.viewoptions = "folds,cursor"
vim.opt.jumpoptions = "stack"

-- sessionoptions
vim.opt.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"

-- normal setting
vim.g.copilot_assume_mapped = true
vim.opt.shortmess = vim.o.shortmess .. "a"
vim.opt.winborder = "rounded" -- set window border
-- vim.opt.clipboard = "unnamedplus" -- use system clipboar
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in nvim
vim.opt.mousemoveevent = true

-- tab
vim.opt.tabstop = 4 -- number of visual spaces per tab
-- vim.opt.sofbstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

vim.opt.undofile = true --save undo file
vim.opt.ruler = false

-- ui config
vim.opt.number = true -- add numbers to each line on the left side
-- vim.opt.relativenumber = true --show relative number
vim.opt.cursorline = false -- highlight cursor line underneath the cursor horizontally
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
vim.o.foldmethod = "manual"
vim.o.foldenable = true
vim.o.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.o.foldlevelstart = -1

-- set statusline && mode
vim.opt.statusline = " "
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.showmode = false

-- add filetype
vim.filetype.add { extension = { mdx = "markdown.mdx", kk = "koka" } }
-- add queries path
vim.opt.runtimepath:append(vim.fn.stdpath "config" .. "/lua/utils")
vim.opt.updatetime = 200

-- close node && perl
vim.g["loaded_node_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

vim.g.clipboard = "osc52"
if vim.g.neovide then
  vim.g.clipboard = false
  vim.g.neovide_title_background_color =
    string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name "Normal" }).bg)
  vim.g.neovide_floating_shadow = false
  vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-v>", '<ESC>"+pa') -- Paste insert mode
  vim.keymap.set("t", "<C-v>", '<C-\\><C-n>"+pa') -- Paste insert mode
end

-- import utils
require "utils.highlight"
