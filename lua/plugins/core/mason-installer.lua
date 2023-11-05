return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
        ensure_installed = {
            'lua-language-server',
            'clangd',
            'rust-analyzer',
            'python-lsp-server',
            'clang-format'
        }
    },
    auto_update = true,
    run_on_start = true,
}
