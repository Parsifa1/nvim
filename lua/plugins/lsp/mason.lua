return {
    {
        "mason-org/mason.nvim",
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
