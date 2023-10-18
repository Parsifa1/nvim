--全局设定
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

require('keymap')
require('option')
-- require('alpha-config')
-- require('alpha-config')

--Lazy.nvim配置--start
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

require("lazy").setup({
    spec = {
        { import = "plugins.core" },
        { import = "plugins.function" },
        { import = "plugins.interface" },
        { import = 'plugins.others' },
        { import = 'plugins.git' },
    },
    ui = {
        border = "rounded"
    },
})
--end
