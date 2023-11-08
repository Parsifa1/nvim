return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = {
		ensure_installed = {
			"lua-language-server",
			"clangd",
			"cpptools",
			"rust-analyzer",
			"python-lsp-server",
			"clang-format",
			"autopep8",
			"rustfmt",
			"stylua",
		},
	},
	auto_update = true,
	run_on_start = true,
}
