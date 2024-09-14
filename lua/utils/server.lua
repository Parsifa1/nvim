local custom = require "custom"
local config = require "utils.lspconfig".config
M = { server = {} }

M.lsp = {
    "html",
    "volar",
    "astro",
    "ts_ls",
    "gopls",
    "lua_ls",
    "jsonls",
    "yamlls",
    "taplo",
    "marksman",
    "tinymist",
    "tailwindcss",
    "mdx_analyzer",
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

local system = {
    -- lsp
    "hls",
    "nixd",
    "clangd",
    "pyright",
}

local windows = {
    "hdl_checker",
    "omnisharp",
}

if vim.uv.os_uname().sysname == "Windows_NT" then
    for _, i in ipairs(windows) do
        table.insert(M.lsp, i)
    end
end

custom.register(M.server, M.lsp, config)
custom.register(M.server, system, config)

return M
