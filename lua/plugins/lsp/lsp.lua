local config = function()
    local custom = require "custom"
    local lspconfig = require "lspconfig"
    local server = require("utils.server").server

    require("lspconfig.ui.windows").default_options.border = "rounded"
    local lsp_keymap = function(bufnr)
        -- lsp-builtin
        local set = function(keys, func, indesc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = indesc })
        end
        set("gr", "<cmd>FzfLua lsp_references<CR>", "[R]eferences")
        set("gi", "<cmd>FzfLua lsp_implementations<CR>", "[I]mplementations")
        set("gk", vim.lsp.buf.signature_help, "LSP Signature help")
        set("gD", "<cmd>FzfLua lsp_document_symbols<CR>", "[D]oc symbols")
        set("gd", "<cmd>lua require('fzf-lua').lsp_definitions{ jump_to_single_result = true }<CR>", "definition")
        set("<leader>ca", require("fastaction").code_action, "[C]ode [A]ction")
        set("<leader>cn", vim.lsp.buf.rename, "[C]ode Item Re[N]ame")
        set("<leader>ct", vim.lsp.buf.type_definition, "[C]ode [T]ype definition")
        set("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostic")
    end

    vim.diagnostic.config {
        virtual_text = { spacing = 4 },
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
            lsp_keymap(args.buf)

            -- inlay hints
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
        end,
    })

    if vim.version().prerelease == "dev" then
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "grr")
        vim.api.nvim_command "LspStart"
    end
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
        "parsifa1/fastaction.nvim",
        event = "LspAttach",
        opts = {},
    },
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        opts = {
            border = { "↖", "─", "╮", "│", "╯", "─", "╰", "│" },
            post_open_hook = function(buf)
                --如果当前buf不等于bufnr,则不设置keymap
                vim.keymap.set("n", "q", require("goto-preview").close_all_win, { buffer = buf })
            end,
            post_close_hook = function(buf)
                vim.keymap.del("n", "q", { buffer = buf })
            end,
            same_file_float_preview = false,
        },
    },
}
