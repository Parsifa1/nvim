return {
  "folke/noice.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    { "<leader>n", "<cmd>NoiceAll<CR>", desc = "open Noice" },
  },
  opts = {
    cmdline = { view = "cmdline" },
    views = {
      confirm = { position = { row = "50%" } },
      hover = { scrollbar = false },
      split = { scrollbar = false },
    },
    lsp = {
      hover = { enabled = false },
      progress = { enabled = false },
      signature = { enabled = false },
    },
    routes = {
      {
        view = "split",
        filter = { event = "msg_show", min_height = 20 },
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "W10" },
            { find = "E21" },
            -- { find = "E492" },
            -- { find = "E486" },
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "%d fewer lines" },
            { find = "%d more lines" },
            { find = "Index out of bounds" },
            { find = "deprecated" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          any = {
            { find = "position_encoding" },
            { find = "Delete existing terminal" },
            { find = "No matching notification found to replace" },
          },
        },
        opts = { skip = true },
      },
    },
  },
}
