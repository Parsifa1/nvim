---@class vim.lsp.Config
return {
  settings = {
    Lua = {
      hint = {
        enable = true,
        arrIndex = "Enable",
        setType = true,
      },
      diagnostics = {
        disable = { "missing-fields", "incomplete-signature-doc" },
      },
    },
  },
}
