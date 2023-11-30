return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
        ensure_installed = {
            "lua-language-server",
            "clangd",
            "codelldb",
            -- "cpptools",
            "rust-analyzer",
            "python-lsp-server",
            "pyright",
            "clang-format",
            "autopep8",
            "marksman",
            "yaml-language-server",
            "haskell-language-server",
            "stylua",
        },
        -- auto_update = true,
        -- run_on_start = true,
    },
}
