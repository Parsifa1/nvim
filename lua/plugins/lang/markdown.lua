---@type LazyPluginSpec

return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = ":cal mkdp#util#install()",
        ft = { "markdown" },
    },
    {
        "parsifa1/markdown-typmath.nvim",
        enabled = false,
        ft = "markdown",
        config = function()
            require("typmath").setup()
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        enabled = true,
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = "markdown",
        opts = {},
    },
}
