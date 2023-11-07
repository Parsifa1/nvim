return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            cpp = { "clang-format" },
        },
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },

    },

}
