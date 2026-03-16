---@type LazyPluginSpec
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "nvim-lspconfig", words = { "lspconfig" } },
      { path = "lazy.nvim", words = { "Lazy.*Spec" } },
      { path = vim.env.VIMRUNTIME },
    },
  },
}
