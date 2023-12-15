return {
    'github/copilot.vim',
    event = "VeryLazy",
    vim.api.nvim_set_keymap("i", "<S-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
}
