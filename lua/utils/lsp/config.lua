local M = {}

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
            "--header-insertion=never",
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
        -- offset_encoding = "utf-8",
        cmd = { "tinymist" },
        single_file_support = true,
        root_dir = function()
            return vim.fn.getcwd()
        end,
        settings = {},
    },
    ts_ls = {
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
    cssls = {
        settings = {
            css = {
                lint = {
                    unknownAtRules = "ignore",
                },
            },
        },
    },
    nil_ls = {
        settings = {
            ["nil"] = {
                nix = { flake = { autoArchive = true } },
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
    hls = {
        root_dir = function()
            return vim.fn.getcwd()
        end,
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
        root_dir = function()
            return vim.fn.getcwd()
        end,
    },
}

---@param server string
M.conf = function(server)
    return M.config[server] or {}
end

return M
