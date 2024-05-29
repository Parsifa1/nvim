return {
    "direnv/direnv.vim",
    enabled = vim.loop.os_uname().sysname == "Linux",
    event = "BufReadPre",
}
