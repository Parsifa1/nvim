return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                cpp = { "clangformat" },
                python = { "autopep8" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                html = { "prettier" },
                astro = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                markdown = { "prettier" },
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
