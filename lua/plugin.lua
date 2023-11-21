local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	require("lazy").setup({
		spec = {
			{ import = "plugins.edit" },
		},
	})
else
	require("lazy").setup({
		spec = {
			{ import = "plugins.core" },
			{ import = "plugins.dap" },
			{ import = "plugins.edit" },
			{ import = "plugins.git" },
			{ import = "plugins.others" },
            { import = "plugins.theme" },
			{ import = "plugins.tools" },
			{ import = "plugins.ui" },
		},
		ui = {
			border = "rounded",
		},
	})
    local theme = require('custom').theme
    vim.cmd.colorscheme(theme)
end

