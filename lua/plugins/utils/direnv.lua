return {
    "direnv/direnv.vim",
    enabled = vim.uv.os_uname().sysname == "Linux",
    event = "User AfterLoad",
}
