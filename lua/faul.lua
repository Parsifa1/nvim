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
    require("lazy").setup {
        defaults = { lazy = true },
        spec = { { import = "plugins" } },
        ui = { border = "rounded", backdrop = 100 },
        install = { colorscheme = { "nordfox" } },
        diff = { cmd = "diffview.nvim" },
        performance = {
            cache = { enabled = true },
            reset_packpath = true, -- reset the package path to improve startup time
            rtp = {
                reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
                ---@type string[]
                paths = {}, -- add any custom paths here that you want to include in the rtp
                disabled_plugins = {
                    "gzip",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "zipPlugin",
                },
            },
        },
    }
end
