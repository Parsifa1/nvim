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

if vim.fn.hostname() == "nixos" then
    M.system = {
        -- lsp
        "hls",
        "nixd",
        "clangd",
        "pyright",
    }
end

return M
