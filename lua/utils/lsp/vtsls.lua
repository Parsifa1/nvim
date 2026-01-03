local mason_path = vim.fn.stdpath "data" .. "/mason/packages/"

---@class vim.lsp.Config
return {
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = mason_path .. "vue-language-server" .. "/node_modules/@vue/language-server",
            configNamespace = "typescript",
            languages = { "vue" },
          },
          {
            name = "@mdx-js/typescript-plugin",
            location = mason_path .. "mdx-analyzer" .. "/node_modules/@mdx-js/language-server",
            languages = { "mdx" },
          },
        },
      },
    },
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
      },
    },
  },
  filetypes = { "vue", "javascriptreact", "typescriptreact", "javascript", "typescript" },
}
