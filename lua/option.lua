if vim.g.vscode then
	vim.opt.timeoutlen = 500
	vim.opt.clipboard = "unnamedplus" -- use system clipboar
else
	-- vim.o.guifont = "JetBrainsMono Nerd Font Mono, 苹方-简:h12"
	vim.g.loaded_python3_provider = 0
	vim.g.neovide_remember_window_size = true
	vim.g.copilot_assume_mapped = true
	vim.loader.enable()
	vim.g.copilot_proxy = "http://127.0.0.1:7891"
	vim.o.shortmess = vim.o.shortmess .. "A"
	-- Hint: use `:h <option>` to figure out the meaning if needed
	vim.opt.clipboard = "unnamedplus" -- use system clipboard
	vim.opt.completeopt = { "menu", "menuone", "noselect" }
	vim.opt.mouse = "a" -- allow the mouse to be used in Nvim
	vim.opt.foldlevel = 99 -- 默认不折叠

	-- Tab
	vim.opt.tabstop = 4 -- number of visual spaces per TAB
	-- vim.opt.sofbstop = 4 -- number of spacesin tab when editing
	vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
	vim.opt.expandtab = true -- tabs are spaces, mainly because of python

	-- UI config
	vim.opt.number = true -- add numbers to each line on the left side
	vim.opt.relativenumber = false --show relative number
	vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
	vim.opt.splitbelow = true -- open new vertical split bottom
	vim.opt.splitright = true -- open new horizontal splits right
	vim.opt.termguicolors = true -- enabl 24-bit RGB color in the TUI
	vim.opt.list = false
	vim.opt.listchars = {
		tab = "  ",
		eol = "⤶",
	}

	-- Searching
	vim.opt.incsearch = true -- search as characters are entered
	vim.opt.hlsearch = false -- do not highlight matches
	vim.opt.ignorecase = true -- ignore case in searches by default
	vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

	-- Indentation
	vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
end
