return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>F",
            function()
                require("conform").format { lsp_fallback = true }
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
                yaml = { "prettier" },
                typst = { "typstyle" },
                nix = { "alejandra" },
            },
            formatters = {
                typstyle = { command = "typstyle" },
                clang_format = {
                    command = "clang-format",
                    pretend_args = {
                        "-style=file:/home/parsifa1/codefield/cpp/.clang-format",
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
