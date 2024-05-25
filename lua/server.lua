M = { server = {} }

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
    "clangd",
    "pyright",
    "lua_ls",
    "tinymist",
    "tailwindcss",
    -- "rust_analyzer",
}

local config = {
    clangd = {
        filetypes = { "cpp", "c" },
        cmd = {
            "clangd",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=never",
            "--offset-encoding=utf-16",
        },
    },
    pyright = {
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
    },
    lua_ls = {
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
    },
    tinymist = {
        cmd = { "tinymist" },
        root_dir = function()
            return vim.fn.getcwd()
        end,
        settings = {},
    },
    tailwindcss = {
        filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "astro",
        },
    },
    nil_ls = {
        settings = {
            ["nil"] = {
                nix = { flake = { autoArchive = false } },
            },
        },
    },
}

for _, i in ipairs(lsp) do
    M.server[i] = config[i] or {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    M.server[i]["capabilities"] = capabilities
end

return M
