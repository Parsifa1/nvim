vim.loader.enable()
vim.g.mapleader = " "
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
    diff = { cmd = "diffview.nvim" },
    -- git = { url_format = "git@github.com:%s.git" },
    -- concurrency = 20,
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            reset = true,
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
