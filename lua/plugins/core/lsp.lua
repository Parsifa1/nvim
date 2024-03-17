local config = function()
    local lspconfig = require "lspconfig"
    local custom = require "custom"
    local lsp_keymap = function(bufnr)
        -- lsp-builtin
        local set = function(keys, func, indesc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
        end
        set("gD", vim.lsp.buf.declaration, "declaration")
        set("gd", vim.lsp.buf.definition, "definition")
        set("K", vim.lsp.buf.hover, "hover")
        -- set("<C-k>", vim.lsp.buf.signature_help, "LSP Signature help")
        set("gi", vim.lsp.buf.implementation, "implementation")
        set("gr", vim.lsp.buf.references, "references")
        set("[d", vim.diagnostic.goto_prev, "goto prev")
        set("]d", vim.diagnostic.goto_next, "goto next")
        set("<leader>q", "<cmd>TroubleToggle<CR>", "quickfix list")
        set("<leader>ca", require("actions-preview").code_actions, "[C]ode [A]ction")
        set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
        set("<leader>cr", require("telescope.builtin").lsp_references, "[C]ode Lsp [R]eferences")
        set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    -- for neodev
    require("neodev").setup {
        library = { types = false, plugins = false },
    }

    -- lsp config in mason
    require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler
            require("lspconfig")[server_name].setup {
                capabilities = capabilities,
            }
        end,
        ["rust_analyzer"] = function()
            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        diagnostics = {
                            disabled = {
                                "needless_return",
                            },
                        },
                    },
                },
            }
        end,
        ["clangd"] = function()
            lspconfig.clangd.setup {
                capabilities = capabilities,
                filetypes = { "cpp", "c" },
                cmd = {
                    "clangd",
                    -- TODO测试版clangd
                    -- "/home/parsifa1/Public/llvm-project/bin/clangd",
                    "--offset-encoding=utf-16",
                },
            }
        end,
        ["pyright"] = function()
            lspconfig.pyright.setup {
                cmd = { "delance-langserver", "--stdio" },
                settings = {
                    python = {
                        disableOrganizeImports = true,
                        pythonPath = "/usr/bin/python3",
                        analysis = {
                            ignore = { "*" },
                            inlayHints = {
                                callArgumentNames = "partial",
                                functionReturnTypes = true,
                                pytestParameters = true,
                                variableTypes = true,
                            },
                        },
                    },
                },
            }
        end,
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            arrIndex = "Enable",
                            setType = true,
                        },
                        diagnostics = {
                            disable = { "missing-fields", "incomplete-signature-doc" },
                        },
                    },
                },
            }
        end,
        ["typst_lsp"] = function()
            lspconfig.typst_lsp.setup {
                capabilities = capabilities,
                cmd = { "/home/parsifa1/Desktop/Test/tinymist" },
                root_dir = function()
                    return vim.fn.getcwd()
                end,
                settings = {},
            }
        end,
        ["tailwindcss"] = function()
            lspconfig.tailwindcss.setup {
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "astro",
                },
            }
        end,
    }

    -- automatically sign up lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "General LSP Attach",
        callback = function(args)
            local bufnr = args.bufnr
            -- buf keymap
            lsp_keymap(bufnr)

            -- for hover
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = custom.border })

            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end

            -- diagnostic
            vim.diagnostic.config {
                virtual_text = { spacing = 4 },
                float = {
                    severity_sort = true,
                    source = "if_many",
                },
                severity_sort = true,
                signs = {
                    text = {
                        ["ERROR"] = custom.icons.diagnostic.Error,
                        ["WARN"] = custom.icons.diagnostic.Warning,
                        ["HINT"] = custom.icons.diagnostic.Hint,
                        ["INFO"] = custom.icons.diagnostic.Information,
                    },
                },
            }
        end,
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        event = { "BufReadPost", "BufNewFile" },
        cmd = "LspInfo",
        config = config,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        config = function()
            require("lsp_signature").setup {
                hint_prefix = "🧐 ",
                handler_opts = {
                    border = require("custom").border,
                },
            }
        end,
    },
    {
        "aznhe21/actions-preview.nvim",
        event = "LspAttach",
        config = function()
            require("actions-preview").setup {
                backend = { "telescope" },
                diff = {
                    algorithm = "patience",
                    ignore_whitespace = true,
                    ignore_cr_at_eol = true,
                    ignore_whitespace_change_at_eol = true,
                },
                telescope = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.6,
                        height = 0.65,
                        prompt_position = "top",
                        preview_cutoff = 20,
                        preview_height = function(_, _, max_lines)
                            return max_lines - 15
                        end,
                    },
                    initial_mode = "normal",
                },
            }
        end,
    },
}
