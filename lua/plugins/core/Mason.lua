return {
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonUpdate",
        },
        event = { "BufNewFile", "BufReadPre" },
        config = function()
            require("mason").setup {
                -- NOTE:为了兼容NIXOS
                PATH = "skip",
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            }
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        cmd = {
            "MasonToolsInstall",
            "MasonToolsInstallSync",
            "MasonToolsUpdate",
            "MasonToolsUpdateSync",
            "MasonToolsClean",
        },
        config = function()
            require("mason-tool-installer").setup {
                ensure_installed = {
                    -- lsp
                    "lua-language-server",
                    "clangd",
                    "rust-analyzer",
                    "marksman",
                    "yaml-language-server",
                    "typst-lsp",
                    "html-lsp",
                    "json-lsp",
                    "typescript-language-server",
                    "astro-language-server",
                    "taplo",
                    "pyright",
                    "ruff_lsp",
                    "tailwindcss-language-server",
                    -- formater
                    "clang-format",
                    "autopep8",
                    "prettier",
                    "stylua",
                    "ruff",
                },
            }
        end,
    },
}
