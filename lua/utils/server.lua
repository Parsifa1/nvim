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
    -- dap
    "codelldb",
}

local config = {
    astro = {
        settings = {
            astro = {
                ["content-intellisense"] = true,
            },
        },
    },
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
                {
                    name = "@mdxjs/typescript-plugin",
                    location = require("mason-registry").get_package("mdx-analyzer"):get_install_path()
                        .. "/node_modules/@mdx/language-server",
                    languages = { "mdx" },
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
    omnisharp = {
        cmd = {
            "dotnet",
            require("mason-registry").get_package("omnisharp"):get_install_path() .. "/libexec/Omnisharp.dll",
        },
        handlers = {
            ["textDocument/definition"] = function(...)
                return require("omnisharp_extended").handler(...)
            end,
        },
        keys = {
            {
                "gd",
                function()
                    require("omnisharp_extended").telescope_lsp_definitions()
                end,
                desc = "Goto Definition",
            },
        },
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
    },
}

if vim.uv.os_uname().sysname == "Windows_NT" then
    table.insert(M.lsp, "hdl_checker")
    table.insert(M.lsp, "omnisharp")
end

-- NOTE: set clangd specially
table.insert(M.lsp, "clangd")

for _, i in ipairs(M.lsp) do
    M.server[i] = config[i] or {}
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    M.server[i]["capabilities"] = capabilities
end

return M
