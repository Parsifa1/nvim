return {
  "direnv/direnv.vim",
  enabled = vim.uv.os_uname().sysname ~= "Windows_NT",
  event = "User AfterFile",
}
