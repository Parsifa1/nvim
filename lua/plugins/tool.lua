return {
    'wellle/targets.vim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'windwp/nvim-autopairs',
    'terryma/vim-expand-region',
    'ggandor/leap.nvim',
    'nvim-lualine/lualine.nvim',
    'ggandor/leap.nvim',

    config = function()
    require('leap').add_default_mappings()
end


}
