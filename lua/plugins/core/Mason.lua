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
        require("mason-lspconfig").setup({
            -- ensure_installed = { "hls@2.4.0.0", "clangd" },
        })
		require("mason-tool-installer").setup({
			ensure_installed = {
				"lua-language-server",
				"clangd",
				"codelldb",
				"rust-analyzer",
				"clang-format",
				"autopep8",
				"marksman",
				"yaml-language-server",
				"haskell-language-server",
                "typst-lsp",
                "prettier",
                "html-lsp",
                "typescript-language-server",
                "astro-language-server",
				-- "stylua",
			},
			-- auto_update = true,
			-- run_on_start = true,
		})
	end,
}
