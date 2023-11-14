return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local function desc(index)
			return { noremap = true, silent = true, desc = index }
		end
		local lspconfig = require("lspconfig")
		-- Customized on_attach function
		-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, desc("goto prev"))
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, desc("goto next"))
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, desc("quickfix list"))

		-- Use an on_attach function to only map the following keys
		local on_attach = function(client, bufnr)
			-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
			local function bufopts_desc(index)
				return { noremap = true, silent = true, buffer = bufnr, desc = index }
			end
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts_desc("declaration"))
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts_desc("definition"))
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts_desc("hover"))
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts_desc("implementation"))
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts_desc("signature help"))
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts_desc("type definition"))
			vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, bufopts_desc("rename"))
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts_desc("code action"))
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts_desc("references"))
			vim.diagnostic.config({
				virtual_text = {
					spacing = 4,
					severity = vim.diagnostic.severity.ERROR,
				},
				float = {
					severity_sort = true,
					source = "if_many",
				},
				signs = false,
				severity_sort = true,
			})
		end
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "General LSP Attach",
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(bufnr, true)
				end
			end,
		})
		require("neodev").setup({
			override = function(root_dir, library)
				library.enabled = true
				library.plugins = true
			end,
		})
		lspconfig.pylsp.setup({
			on_attach = on_attach,
		})
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					hint = {
						enable = true,
						arrIndex = "Enable",
						setType = true,
					},
					diagnostics = {
						disable = { "missing-fields", "incomplete-signature-doc" },
						globals = { "vim" },
					},
				},
			},
		})
		lspconfig.clangd.setup({
			on_attach = on_attach,
			filetypes = { "cpp", "c" },
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})
		lspconfig.rust_analyzer.setup({
			on_attach = on_attach,
		})
	end,
}
