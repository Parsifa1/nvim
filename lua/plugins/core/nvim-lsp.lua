local function desc(index)
    return { noremap = true, silent = true, desc = index }
end

local function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "lukas-reineke/lsp-format.nvim",
        "ray-x/lsp_signature.nvim",
    },
    event = "User FileOpened",
    config = function()
        local lspconfig = require("lspconfig")
        -- Set diagnostic icons
        vim.iter(require("custom").icons.diagnostic):each(function(type, icon)
            local hl = "DiagnosticSign" .. firstToUpper(type)
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end)

        -- Customized on_attach function
        vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, desc("open float"))
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, desc("goto prev"))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, desc("goto next"))
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, desc("quickfix list"))

        -- Use an on_attach function to only map the following keys
        local on_attach = function(ev)
            local bufnr = ev.bufnr
            local function bufopts_desc(index)
                return { noremap = true, silent = true, buffer = bufnr, desc = index }
            end
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts_desc("declaration"))
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts_desc("definition"))
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts_desc("hover"))
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts_desc("implementation"))
            -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts_desc("signature help"))
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts_desc("type definition"))
            vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, bufopts_desc("rename"))
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts_desc("code action"))
            vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts_desc("references"))
            vim.diagnostic.config({
                virtual_text = {
                    spacing = 4,
                    severity = { min = vim.diagnostic.severity.WARN }
                },
                float = {
                    severity_sort = true,
                    source = "if_many",
                },
                signs = true,
                severity_sort = true,
            })
        end

        --for lsp signature
        require("lsp_signature").setup({
            hint_prefix = "🧐 ", --  NOTE: for the terminal not support emoji, might crash
            handler_opts = {
                border = require("custom").border,
            },
        })

        -- for inlay hints
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

        -- for lsp config in mason
        require("mason-lspconfig").setup_handlers {
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {
                    on_attach = on_attach,
                }
            end,
            ["clangd"] = function()
                lspconfig.clangd.setup({
                    on_attach = on_attach,
                    filetypes = { "cpp", "c" },
                    cmd = {
                        "clangd",
                        "--offset-encoding=utf-16",
                    },
                })
            end,
            ["lua_ls"] = function()
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
            end
        }
    end,
}

