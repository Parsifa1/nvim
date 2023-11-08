return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			cpp = { "clang-format" },
			python = { "autopep8" },
			rust = { "rustfmt" },
			lua = { "stylua" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
		formatters = {
			clang_format = {
				pretend_args = {
					"-style=file",
				},
			},
		},
	},
}
