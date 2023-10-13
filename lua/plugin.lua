local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local lualine = {
}
require("lazy").setup({
    spec = { import = "config" },
    ui = {
        border = "rounded"
    },

    -- 'wellle/targets.vim',
    -- 'tpope/vim-surround',
    -- 'tpope/vim-repeat',
    -- 'windwp/nvim-autopairs',
    -- 'terryma/vim-expand-region',
    -- 'max397574/better-escape.nvim',
    -- 'ggandor/leap.nvim',
    -- -- --LSP 
    -- 'nvim-lualine/lualine.nvim',
    -- 'nvim-tree/nvim-tree.lua',

})
