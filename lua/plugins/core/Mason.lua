return {
    "williamboman/mason.nvim",
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    event = {
        "BufReadPre",
        "CmdlineEnter",
    },

    config = function()
        require("mason").setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        }
        require("mason-tool-installer").setup {
            ensure_installed = {
                "lua-language-server",
                "clangd",
                "codelldb",
                "rust-analyzer",
                "clang-format",
                "autopep8",
                "marksman",
                "yaml-language-server",
                "haskell-language-server",
                "typst-lsp",
                "prettier",
                "html-lsp",
                "typescript-language-server",
                "astro-language-server",
                "stylua",
                "taplo",
                "pyright",
                "ruff",
                "ruff_lsp",
            },
            -- auto_update = true,
            run_on_start = true,
        }
    end,
}
