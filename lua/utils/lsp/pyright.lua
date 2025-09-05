---@class vim.lsp.Config
return {
  cmd = { "delance-langserver", "--stdio" },
  settings = {
    python = {
      disableOrganizeImports = true,
      pythonPath = vim.fn.exepath "python",
      analysis = {
        extraPaths = { vim.fn.getcwd() },
        ignore = { "*" },
        inlayHints = {
          callArgumentNames = "partial",
          functionReturnTypes = true,
          pytestParameters = true,
          variableTypes = true,
        },
      },
    },
  },
}
