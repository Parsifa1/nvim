--全局设定
require('keymap')
require('option')

--Lazy.nvim配置
--START
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
--END
