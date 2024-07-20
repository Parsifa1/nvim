---@type LazyPluginSpec

return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = ":cal mkdp#util#install()",
    ft = { "markdown" },
}
