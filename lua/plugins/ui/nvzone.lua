return {
    { "nvzone/volt", lazy = true },
    {
        "nvzone/showkeys",
        cmd = "ShowkeysToggle",
        keys = { { "<leader>sk", "<cmd>ShowkeysToggle<CR>", desc = "Toggle Shhokeys" } },
        opts = { position = "bottom-center" },
    },
    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
}
