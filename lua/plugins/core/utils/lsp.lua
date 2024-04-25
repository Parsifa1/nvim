local config = function()
    local lspconfig = require "lspconfig"
    local custom = require "custom"
    local server = require("server").server
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

    -- lspconfig
    for lsp, config in (vim.iter(server)) do
        lspconfig[lsp].setup(config)
    end

    -- automatically sign up lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "General LSP Attach",
        callback = function(args)
            -- buf keymap
            lsp_keymap(args.bufnr)

            -- for hover
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = custom.border })

            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end

            -- diagnostic
            vim.diagnostic.config {
                virtual_text = { spacing = 4 },
                float = { severity_sort = true, source = "if_many" },
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
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
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
        "folke/neodev.nvim",
        event = "LspAttach",
        opts = {
            library = { types = false, plugins = false },
        },
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
