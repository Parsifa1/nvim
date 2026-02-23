---@class vim.lsp.Config
return {
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrIndex = "Enable",
        setType = true,
      },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
      diagnostics = {
        disable = {
          "missing-fields",
          "incomplete-signature-doc",
          "param-type-mismatch",
          "assign-type-mismatch",
          "undefined-doc-name",
        },
        globals = { "vim", "Snacks", "MiniFiles" },
      },
    },
  },
}
