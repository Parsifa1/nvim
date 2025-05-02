local M = { system = {} }

M.tools = {
    -- formatter
    "prettier",
    "stylua",
    "ruff",
    "typstyle",
    "clang-format",
    -- dap
    "codelldb",
}

M.system = {
    -- lsp
    "hls",
    "nixd",
    "clangd",
    "pyright",
}

return M
