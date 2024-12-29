return {
    "moonbit-community/moonbit.nvim",
    ft = { "moonbit" },
    opts = {
        -- optionally disable the treesitter integration
        treesitter = { enabled = true },
        -- configure the language server integration
        -- set `lsp = false` to disable the language server integration
        lsp = {},
    },
}
