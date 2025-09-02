local M = {}

M.system = {
    -- lsp
    "hls",
    "nixd",
    "koka",
    "clangd",
    "pyright",
}

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

function M.init()
    -- NOTE: windows have IO blocking issue with vim.lsp.enable
    if vim.uv.os_uname().sysname == "Windows_NT" then
        vim.lsp.enable = vim.schedule_wrap(vim.lsp.enable)
    end

    -- lsp installed by system
    for _, lsp in ipairs(M.system) do
        vim.lsp.enable(lsp)
    end
    -- lsp installed by mason
    require("mason-lspconfig").setup {
        ensure_installed = {},
        automatic_enable = {
            exclude = { "rust_analyzer", "dprint" },
        },
    }
end

return M
