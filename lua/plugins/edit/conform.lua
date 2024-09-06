return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>F",
            function()
                require("conform").format { lsp_format = "fallback" }
            end,
            desc = "Format Document",
            mode = { "n", "v" },
        },
    },
    config = function()
        require("conform").setup {
            formatters_by_ft = {
                cpp = { "clang_format" },
                python = { "ruff_fix", "ruff_format" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                html = { "prettier" },
                astro = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                markdown = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
                typst = { "typstyle" },
                nix = { "nixfmt" },
            },
            formatters = {
                clang_format = {
                    command = "clang-format",
                    prepend_args = {
                        "-style=file:/home/parsifa1/codefield/cpp/.clang-format",
                    },
                },
                prettier = {
                    prepend_args = {
                        "--tab-width 2",
                    },
                },
            },
        }
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        vim.o.formatprg = "v:lua.require'conform'.formatprg()"
    end,
}
