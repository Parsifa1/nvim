return {
  "ravitemer/mcphub.nvim",
  cmd = "MCPHub",
  dependencies = { "nvim-lua/plenary.nvim" },
  build = "bundled_build.lua",
  opts = {
    use_bundled_binary = true,
  },
}
