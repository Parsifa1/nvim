return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>q", "<Cmd>Trouble diagnostics <CR>", desc = "Trouble" },
  },
  opts = {
    auto_close = true,
    focus = true,
    keys = { ["<cr>"] = "jump_close" },
    win = { size = { width = 0.3, height = 0.4 } },
  },
}
