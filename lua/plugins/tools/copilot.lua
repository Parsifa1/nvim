return {
    'github/copilot.vim',
    event = "VeryLazy",
    vim.api.nvim_set_keymap("i", "J", 'copilot#Accept("<CR>")', { silent = true, expr = true })
}
