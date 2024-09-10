local custom = require "custom"
local config = require "utils.lspconfig"
M = { server = {} }

M.lsp = {
    "astro",
    "html",
    "ts_ls",
    "gopls",
    "lua_ls",
    "jsonls",
    "yamlls",
    "taplo",
    "marksman",
    "tailwindcss",
    "mdx_analyzer",
    "tinymist",
    "nginx_language_server",
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

local system = {
    "clangd",
    "pyright",
    "nil_ls",
    "hls",
}

if vim.uv.os_uname().sysname == "Windows_NT" then
    for _, i in ipairs(windows_nt) do
        table.insert(M.lsp, i)
    end
end

custom.register(M.server, M.lsp, config)
custom.register(M.server, system, config)

return M
