return {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
        progress = {
            lsp = {
                progress_ringbuf_size = 512,
            },
        },
        notification = {
            window = { winblend = 0 },
        },
    },
}
