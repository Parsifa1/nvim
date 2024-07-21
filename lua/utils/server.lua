M = { server = {} }

M.lsp = {
    "volar",
    "html",
    "yamlls",
    "nil_ls",
    "gopls",
    "astro",
    "taplo",
    "jsonls",
    "tsserver",
    "pyright",
    "lua_ls",
    "tinymist",
    "marksman",
    "tailwindcss",
    "nginx_language_server",
}

M.formatter = {
    "prettier",
    "stylua",
    "ruff",
    "typstyle",
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
                pythonPath = vim.fn.exepath "python3",
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
    tsserver = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                        .. "/node_modules/@vue/language-server",
                    languages = { "vue" },
                },
            },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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

-- NOTE: set clangd specially
M.server["clangd"] = config["clangd"]

for _, i in ipairs(M.lsp) do
    M.server[i] = config[i] or {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    M.server[i]["capabilities"] = capabilities
end

return M
