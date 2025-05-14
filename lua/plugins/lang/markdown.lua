---@type LazyPluginSpec

return {
    {
        "parsifa1/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = ":cal mkdp#util#install()",
        ft = { "markdown" },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            file_types = { "markdown", "codecompanion" },
        },
        ft = { "markdown", "codecompanion" },
    },
}
