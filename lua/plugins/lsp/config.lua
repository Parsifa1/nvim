local custom = require "config.custom"

local config = function()
    -- init lsp config && system lsp
    require("utils.lspstart").init()

    local lsp_keymap = function(bufnr)
        -- lsp-builtin
        local set = function(keys, func, indesc) vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc }) end
        set("gr", "<cmd>FzfLua lsp_references<CR>", "[R]eferences")
        set("gi", "<cmd>FzfLua lsp_implementations<CR>", "[I]mplementations")
        set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
        set("gt", "<cmd>FzfLua lsp_typedefs<CR>", "LSP [T]ype definition")
        set("gD", "<cmd>FzfLua lsp_document_symbols<CR>", "[D]oc symbols")
        set("gd", "<cmd>lua require('fzf-lua').lsp_definitions{ jump1 = true }<CR>", "definition")
        set("<leader>ca", require("fastaction").code_action, "[C]ode [A]ction")
        set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
        set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
        set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
    end

    vim.diagnostic.config {
        -- virtual_text = { spacing = 4 },
        virtual_lines = { current_line = true },
        jump = { float = true },
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

    -- automatically sign up lsp
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "General LSP Attach",
        callback = function(args)
            -- buf keymap
            lsp_keymap(args.buf)
            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                if client:supports_method "textDocument/inlayHint" then vim.lsp.inlay_hint.enable(true) end
                if vim.fn.has "nvim-0.12" == 1 and client:supports_method "textDocument/documentColor" then
                    vim.lsp.document_color.enable(true, args.buf, { style = "virtual" })
                end
            end
        end,
    })

    if vim.fn.has "nvim-0.11" == 1 then
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "grt")
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason-org/mason-lspconfig.nvim" },
        -- event = { "CursorHold", "CursorHoldI" },
        -- event = "User AstroFile",
        event = "User AfterFile",
        cmd = "LspInfo",
        config = config,
    },
    {
        "Chaitanyabsprip/fastaction.nvim",
        event = "LspAttach",
        opts = {},
    },
    {
        "kosayoda/nvim-lightbulb",
        event = "LspAttach",
        opts = {
            autocmd = { enabled = true },
        },
    },
}
