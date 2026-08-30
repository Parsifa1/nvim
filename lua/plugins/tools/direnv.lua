return {
  "direnv/direnv.vim",
  enabled = vim.fn.executable "direnv" == 1,
  event = "User AfterFile",
}
