local stdpath = vim.fn.stdpath
local compile = function(dir)
    local autoload = require("nfnl.module")["autoload"]
    local compile = autoload "nfnl.compile"
    local dir0 = (dir or vim.fn.getcwd())
    local opts = autoload("nfnl.config")["find-and-load"](dir0)
    local root_dir = opts["root-dir"]
    local cfg = opts["cfg"]
    compile["all-files"] { ["root-dir"] = root_dir, cfg = cfg }
end

-- init setup
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- pofile
if vim.env.PROF then
    local snacks = stdpath "data" .. "/lazy/snacks.nvim"
    vim.opt.rtp:append(snacks)
    require("snacks.profiler").startup {
        startup = { event = "VimEnter" },
    }
end

-- install lazy
local lazypath = stdpath "data" .. "/lazy/lazy.nvim"
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

-- install nfnl
local nfnl = stdpath "data" .. "/lazy/nfnl"
if not vim.uv.fs_stat(nfnl) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/Olical/nfnl.git",
        "--branch=main",
        nfnl,
    }
end
vim.opt.rtp:prepend(nfnl)
require("nfnl").setup()

-- init fennel
package.path = package.path .. ";" .. stdpath "data" .. "/nfnl/lua/?.lua"
if not vim.uv.fs_stat(stdpath "data" .. "/nfnl") then
    local fnl = vim.fn.stdpath "config"
    compile(fnl)
end

--- start up file
require "packer"
require "keymap"
require "option"
