return {
  "gnsfujiwara/suda.nvim",
  cmd = { "SudaWrite", "SudaRead" },
  event = "User AfterFile",
  opts = {
    smart_edit = true,
    noninteractive = true,
  },
  keys = {
    { "<leader>sr", "<cmd>SudaRead<CR>", desc = "Read Sudo Files" },
    { "<leader>sw", "<cmd>SudaWrite<CR>", desc = "Write Sudo Files" },
  },
}
