return {
    {
        "williamboman/mason.nvim",
        keys = {
        { "<leader>m", "<cmd>Mason<CR>", desc = "open Mason" },
        },
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonUpdate",
        },
        config = function()
            require("mason").setup {
                -- PATH = "append", -- NOTE:为了兼容NIXOS
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
                    "marksman",
                    "yaml-language-server",
                    "tinymist",
                    "html-lsp",
                    "json-lsp",
                    "typescript-language-server",
                    "vue-language-server",
                    "astro-language-server",
                    "taplo",
                    "ruff-lsp",
                    "tailwindcss-language-server",
                    "gopls",
                    -- "nil",
                    "rust-analyzer",
                    "pyright",

                    -- formater
                    "alejandra",
                    "typstyle",
                    "prettier",
                    "stylua",
                    "ruff",
                },
            }
        end,
    },
}
