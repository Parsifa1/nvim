return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    ft = { "markdown" },
}
