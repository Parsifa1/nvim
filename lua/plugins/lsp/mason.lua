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
                PATH = "append", -- NOTE:为了兼容NIXOS
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                    "github:Parsifa1/typstyle-mason-registry",
                },

                ui = {
                    backdrop = 100,
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
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        cmd = {
            "MasonToolsInstall",
            "MasonToolsInstallSync",
            "MasonToolsUpdate",
            "MasonToolsUpdateSync",
            "MasonToolsClean",
        },
        config = function()
            local installed = require("utils.lsp.server").tools

            for _, sv in ipairs(require("utils.lsp.server").lsp) do
                table.insert(installed, sv)
            end

            require("mason-tool-installer").setup {
                ensure_installed = installed,
            }
        end,
    },
}
