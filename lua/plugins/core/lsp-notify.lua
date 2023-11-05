return {
    'mrded/nvim-lsp-notify',
    enabled = false,
    config = function()
        require('lsp-notify').setup({})
    end
}
