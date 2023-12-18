return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = {
            cpp = { "clang-format" },
            python = { "autopep8" },
            -- lua = { "stylua" },
            rust = { "rustfmt" },
            html = {"prettier"},
        },
        formatters = {
            clang_format = {
                pretend_args = {
                    "-style=file:/home/parsifa1/.clang-format",
                },
            },
            rustfmt = {
                command = "rustfmt",
            },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatprg = "v:lua.require'conform'.formatprg()"
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
