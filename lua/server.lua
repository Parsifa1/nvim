M = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

M.server = {}

local lsp = {
    "tsserver",
    "yamlls",
    "html",
    "marksman",
    "hls",
    "nil_ls",
    "astro",
    "taplo",
    "jsonls",
    "ruff_lsp",
    "rust_analyzer",
    "clangd",
    "pyright",
    "lua_ls",
    "tinymist",
    "tailwindcss",
}

for _, s in ipairs(lsp) do
    M.server[s] = {}
end

M.server["rust_analyzer"] = {
    settings = {
        ["rust-analyzer"] = { diagnostics = { disabled = { "needless_return" } } },
    },
}
M.server["clangd"] = {
    filetypes = { "cpp", "c" },
    cmd = {
        "clangd",
        -- TODO测试版clangd
        -- "/home/parsifa1/Public/llvm-project/bin/clangd",
        "--offset-encoding=utf-16",
    },
}
M.server["pyright"] = {
    cmd = { "delance-langserver", "--stdio" },
    settings = {
        python = {
            disableOrganizeImports = true,
            pythonPath = "/usr/bin/python3",
            analysis = {
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
M.server["lua_ls"] = {
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
M.server["tinymist"] = {
    cmd = { "tinymist", "--mirror", vim.env.HOME .. "/tinymist-input-mirror.json" },
    root_dir = function()
        return vim.fn.getcwd()
    end,
    settings = {},
}
M.server["tailwindcss"] = {
    filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "astro",
    },
}

for _, server in ipairs(M.server) do
    server["capabilities"] = capabilities
end

return M
