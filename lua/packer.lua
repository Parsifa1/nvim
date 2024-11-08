vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    defaults = { lazy = true },
    spec = { { import = "plugins" } },
    ui = { border = "rounded", backdrop = 100 },
    install = { colorscheme = { "gruvbox-material" } },
    diff = { cmd = "browser" },
    -- git = { url_format = "git@github.com:%s.git" },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        throttle = {
            enabled = true,
        },
        rtp = {
            reset = true,
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },
}
