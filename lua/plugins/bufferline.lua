return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            -- 使用 nvim 内置lsp
            diagnostics = "nvim_lsp",
            -- 左侧让出 nvim-tree 的位置
            offsets = { {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            } }
        }

    }
}
