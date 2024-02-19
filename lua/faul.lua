---@diagnostic disable: undefined-field
vim.loader.enable()
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
    require("lazy").setup {
        spec = {
            { import = "plugins.edit" },
        },
    }
else
    require("lazy").setup("plugins", {
        ui = {
            border = "rounded",
        },
        install = {
            colorscheme = { "default" },
        },
        diff = {
            cmd = "diffview.nvim",
        },
        performance = {
            rtp = {
                disabled_plugins = {
                    "gzip",
                    -- "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
    })
end
