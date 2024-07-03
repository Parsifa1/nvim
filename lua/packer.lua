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
    -- concurrency = vim.uv.available_parallelism(),
    spec = { { import = "plugins" } },
    ui = { border = "rounded", backdrop = 100 },
    install = { colorscheme = { "nordfox" } },
    diff = { cmd = "diffview.nvim" },
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
