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
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
    },
}
