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
                    "lua-language-server",
                    "clangd",
                    "codelldb",
                    "rust-analyzer",
                    "clang-format",
                    "autopep8",
                    "marksman",
                    "yaml-language-server",
                    -- "haskell-language-server",
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
                    "tailwindcss-language-server",
                },
                -- run_on_start = true,
            }
        end,
    },
}
