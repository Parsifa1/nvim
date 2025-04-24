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
                registries = { "github:mason-org/mason-registry" },

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
}
