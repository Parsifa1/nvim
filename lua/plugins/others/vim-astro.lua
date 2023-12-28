return {
    {
        "wuelnerdotexe/vim-astro",
        ft = "astro",
        init = function()
            -- Astro configuration variables.
            vim.g.astro_typescript = "enable"
            vim.g.astro_stylus     = "disable"
        end,
    },
}
