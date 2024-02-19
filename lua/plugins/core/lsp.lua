local config = function()
    local lspconfig = require "lspconfig"
    local custom = require "custom"

    -- automatically sign up lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "General LSP Attach",
        callback = function(args)
            local bufnr = args.bufnr
            local set = function(keys, func, indesc)
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
            end
            -- for hover
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = custom.border })

            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(bufnr, true)
            end

            -- lsp-builtin
            set("gD", vim.lsp.buf.declaration, "declaration")
            set("gd", vim.lsp.buf.definition, "definition")
            set("K", vim.lsp.buf.hover, "hover")
            set("<C-k>", vim.lsp.buf.signature_help, "LSP Signature help")
            set("gi", vim.lsp.buf.implementation, "implementation")
            set("<leader>cd", vim.lsp.buf.type_definition, "type definition")
            set("<leader>cn", vim.lsp.buf.rename, "rename")
            set("gr", vim.lsp.buf.references, "references")
            set("[d", vim.diagnostic.goto_prev, "goto prev")
            set("]d", vim.diagnostic.goto_next, "goto next")
            set("<leader>q", "<cmd>TroubleToggle<CR>", "quickfix list")
            set("<leader>cr", require("telescope.builtin").lsp_references, "Peek References")
            set("<leader>ca", require("actions-preview").code_actions, "Code Action")

            -- diagnostic
            vim.diagnostic.config {
                virtual_text = { spacing = 4 },
                float = {
                    severity_sort = true,
                    source = "if_many",
                },
                severity_sort = true,
                -- Set diagnostic icons
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

    -- for neodev
    require("neodev").setup {
        library = { types = false, plugins = false },
    }

    -- lsp config in mason
    require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler
            require("lspconfig")[server_name].setup {}
        end,
        ["clangd"] = function()
            lspconfig.clangd.setup {
                filetypes = { "cpp", "c" },
                cmd = {
                    -- "clangd",
                    -- TODO测试版clangd
                    "/home/parsifa1/Public/test/build/bin/clangd",
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
                root_dir = function()
                    return vim.fn.getcwd()
                end,
                settings = {
                    exportPdf = "onType",
                },
            }
        end,
        ["tailwindcss"] = function()
            lspconfig.tailwindcss.setup {
                filetypes = {
                    "html",
                    "css",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
            }
        end,
    }
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
        },
        event = "BufReadPre",
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
                diff = {
                    algorithm = "patience",
                    ignore_whitespace = true,
                },
                telescope = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.8,
                        height = 0.9,
                        prompt_position = "top",
                        preview_cutoff = 20,
                        preview_height = function(_, _, max_lines)
                            return max_lines - 15
                        end,
                    },
                },
            }
        end,
    },
}
