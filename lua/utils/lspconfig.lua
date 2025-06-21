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

M.config = {
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
    tinymist = {
        cmd = { "tinymist" },
        settings = {},
    },
    ts_ls = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.exepath "vue-language-server" .. "/node_modules/@vue/language-server",
                    languages = { "vue" },
                },
                {
                    name = "@mdxjs/typescript-plugin",
                    location = vim.fn.exepath "mdx-analyzer" .. "/node_modules/@mdx/language-server",
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
    cssls = {
        settings = {
            css = {
                lint = {
                    unknownAtRules = "ignore",
                },
            },
        },
    },
    omnisharp = {
        cmd = {
            "dotnet",
            vim.fn.exepath "omnisharp" .. "/libexec/Omnisharp.dll",
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
    hls = {
        settings = {
            haskell = {
                plugin = {
                    ["semanticTokens"] = {
                        globalOn = true,
                    },
                },
            },
        },
    },
    verible = {
        cmd = { "verible-verilog-ls", "--rules=-explicit-parameter-storage-type" },
    },
}

M.init = function()
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
