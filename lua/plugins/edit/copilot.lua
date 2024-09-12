return {
    "github/copilot.vim",
    event = "User AfterLoad",
    vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true }),
}
