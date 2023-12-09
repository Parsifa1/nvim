return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.1.*',
    build = function() require 'typst-preview'.update() end,
    opts = {
        debug = false,
        get_root = function(bufnr_of_typst_buffer)
            return vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')
        end,
    }
}
