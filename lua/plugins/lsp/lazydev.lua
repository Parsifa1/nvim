---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "lazy.nvim", words = { "LazyPluginSpec" } },
      { path = vim.env.VIMRUNTIME },
    },
  },
}
