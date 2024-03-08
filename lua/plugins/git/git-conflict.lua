local opts = {
    default_mappings = true,
    disable_diagnostics = false,
    highlights = {
        incoming = "DiffText",
        current = "DiffAdd",
    },
}

return {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = opts,
    event = "Lspattach",
}
