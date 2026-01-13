return {
  "akinsho/git-conflict.nvim",
  event = "User AfterFile",
  version = "*",
  opts = {
    disable_diagnostics = true,
    default_mappings = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "ca",
      next = "]c",
      prev = "[c",
    },
  },
}
