local config = function()
    require("lspconfig.ui.windows").default_options.border = "rounded"
    local lspconfig = require "lspconfig"
    local custom = require "custom"
    local server = require("utils.server").server
    local lsp_keymap = function(bufnr)
        -- lsp-builtin
        local set = function(keys, func, indesc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
        end
        set("K", vim.lsp.buf.hover, "hover")
        set("gD", vim.lsp.buf.declaration, "declaration")
        set("gd", vim.lsp.buf.definition, "definition")
        set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
        set("gi", vim.lsp.buf.implementation, "implementation")
        set("gr", require("telescope.builtin").lsp_references, "[R]eferences")
        set("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        set("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        set("<leader>ca", require("fastaction").code_action, "[C]ode [A]ction")
        set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
        set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
        set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
    end

    vim.diagnostic.config {
        virtual_text = { spacing = 4 },
        float = {
            border = custom.border,
            severity_sort = true,
            source = "if_many",
        },
        severity_sort = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = custom.icons.diagnostic.Error,
                [vim.diagnostic.severity.WARN] = custom.icons.diagnostic.Warning,
                [vim.diagnostic.severity.HINT] = custom.icons.diagnostic.Hint,
                [vim.diagnostic.severity.INFO] = custom.icons.diagnostic.Information,
            },
        },
    }

    -- lspconfig
    for lsp, config in (vim.iter(server)) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[lsp].setup(config)
    end

    -- automatically sign up lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "General LSP Attach",
        callback = function(args)
            -- buf keymap
            lsp_keymap(args.bufnr)

            -- for hover
            -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = custom.border })

            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
        end,
    })

    vim.api.nvim_command "LspStart"
end

return {
    {
        "neovim/nvim-lspconfig",
        -- event = { "BufReadPre", "BufNewFile" },
        event = "User AfterLoad",
        cmd = "LspInfo",
        config = config,
    },
    {
        "Chaitanyabsprip/fastaction.nvim",
        event = "LspAttach",
        opts = {},
    },
}
