return {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                cpp = { "clangformat" },
                python = { "ruff_fix", "ruff_format" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                html = { "prettier" },
                astro = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                markdown = { "prettier" },
                javascriptreact = { "prettier" },
            },
            formatters = {
                clangformat = {
                    command = "/home/parsifa1/.local/share/nvim/mason/bin/clang-format",
                    pretend_args = {
                        "-style=file:/home/parsifa1/.clang-format",
                    },
                },
                prettier = {
                    pretend_args = {
                        "--tab-width 2",
                    },
                },
            },
        }
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        vim.o.formatprg = "v:lua.require'conform'.formatprg()"
    end,
}
