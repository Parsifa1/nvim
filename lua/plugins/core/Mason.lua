return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua-language-server",
				"clangd",
				"codelldb",
				"rust-analyzer",
				"python-lsp-server",
				"pyright",
				"clang-format",
				"autopep8",
				"marksman",
				"yaml-language-server",
				"haskell-language-server",
				-- "cpptools",
				-- "stylua",
			},
			-- auto_update = true,
			-- run_on_start = true,
		})
	end,
}
