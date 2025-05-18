return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>F",
            function()
                require("conform").format()
            end,
            desc = "Format Document",
            mode = { "n", "v" },
        },
    },
    config = function()
        require("conform").setup {
            default_format_opts = {
                stop_after_first = true,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                nix = { "nixfmt" },
                lua = { "stylua" },
                rust = { "rustfmt" },
                typst = { "typstyle" },
                python = { "ruff_format" },
                cpp = { "clang_format" },
                css = { "dprint" },
                astro = { "dprint" },
                javascriptreact = { "dprint" },
                typescriptreact = { "dprint" },
                markdown = { "dprint", "prettier" },
                javascript = { "dprint", "prettier" },
                typescript = { "dprint", "prettier" },
                html = { "dprint", "prettier" },
                yaml = { "dprint", "prettier" },
                json = { "dprint", "prettier" },
                jsonc = { "dprint", "prettier" },
                haskell = { "fourmolu" },
            },
            formatters = {
                clang_format = { command = "clang-format" },
            },
        }
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        vim.o.formatprg = "v:lua.require'conform'.formatprg()"
    end,
}
