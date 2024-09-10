local custom = require "custom"
local config = require "utils.lspconfig"
M = { server = {} }

M.lsp = {
    "volar",
    "html",
    "yamlls",
    "gopls",
    "astro",
    "taplo",
    "jsonls",
    "ts_ls",
    "pyright",
    "lua_ls",
    "tinymist",
    "marksman",
    "tailwindcss",
    "nginx_language_server",
    "mdx_analyzer",
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

local windows_nt = {
    "hdl_checker",
    "omnisharp",
}

local locally = {
    "clangd",
    "nil_ls",
}

if vim.uv.os_uname().sysname == "Windows_NT" then
    for _, i in ipairs(windows_nt) do
        table.insert(M.lsp, i)
    end
end

custom.register(M.server, M.lsp, config)
custom.register(M.server, locally, config)

return M
