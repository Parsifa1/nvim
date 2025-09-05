---@class vim.lsp.Config
return {
  on_attach = function(client, _) client.server_capabilities.documentHighlightProvider = false end,
  filetypes = {
    "html",
    "css",
    "vue",
    "javascriptreact",
    "typescriptreact",
    "astro",
  },
  settings = {
    css = {
      lint = { unknownAtRules = "ignore" },
    },
  },
}
