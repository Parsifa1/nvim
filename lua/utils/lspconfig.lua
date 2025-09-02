local M = {}

M.system = {
    -- lsp
    -- "hls",
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

M.config = {
    astro = {
        settings = {
            astro = { ["content-intellisense"] = true },
        },
    },
    clangd = {
        filetypes = { "cpp", "c" },
        cmd = {
            "clangd",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
            "--offset-encoding=utf-16",
            "--function-arg-placeholders=0",
        },
        init_options = {
            fallbackFlags = {
                "-std=c++2b",
                "-xc++",
                "-Wall",
                "-Wno-unused-variable",
                "-Wno-vla-cxx-extension",
                "-Wno-unknown-attributes  ",
                "-Wno-unused-but-set-variable ",
                "-fsyntax-only",
                "-static-libgcc",
                "-l stdc++",
            },
        },
    },
    pyright = {
        cmd = { "delance-langserver", "--stdio" },
        settings = {
            python = {
                disableOrganizeImports = true,
                pythonPath = vim.fn.exepath "python",
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
    vtsls = {
        settings = {
            vtsls = {
                tsserver = {
                    globalPlugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath "data"
                                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            configNamespace = "typescript",
                            languages = { "vue" },
                        },
                    },
                },
            },
            typescript = {
                inlayHints = {
                    variableTypes = { enabled = true },
                    parameterTypes = { enabled = true },
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                },
            },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    },
    tailwindcss = {
        filetypes = {
            "html",
            "css",
            "vue",
            "javascriptreact",
            "typescriptreact",
            "astro",
        },
    },
    cssls = {
        filetypes = {
            "html",
            "css",
            "vue",
            "javascriptreact",
            "typescriptreact",
            "astro",
        },
        settings = {
            css = {
                lint = { unknownAtRules = "ignore" },
            },
        },
    },
    hls = {
        settings = {
            haskell = {
                plugin = {
                    ["semanticTokens"] = { globalOn = true },
                },
            },
        },
    },
}
function M.init()
    -- NOTE: windows have IO blocking issue with vim.lsp.enable
    if vim.uv.os_uname().sysname == "Windows_NT" then
        vim.lsp.enable = vim.schedule_wrap(vim.lsp.enable)
    end
    -- init lsp config
    for lsp, config in pairs(M.config) do
        vim.lsp.config[lsp] = config
    end

    -- lsp installed by system
    for _, lsp in ipairs(M.system) do
        vim.lsp.enable(lsp)
    end
end

return M
