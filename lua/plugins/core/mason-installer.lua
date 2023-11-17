return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"lua-language-server",
			"clangd",
			"cpptools",
			"rust-analyzer",
			"python-lsp-server",
            "pyright",
			"clang-format",
			"autopep8",
			"stylua",
		},
		-- auto_update = true,
		-- run_on_start = true,
	},
}
