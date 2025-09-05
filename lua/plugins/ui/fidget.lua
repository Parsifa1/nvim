return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        progress_ttl = 15,
      },
      lsp = {
        progress_ringbuf_size = 512,
      },
    },
    notification = {
      window = { winblend = 0 },
    },
  },
}
