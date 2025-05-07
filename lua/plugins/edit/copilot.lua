---@type LazyPluginSpec
return {
    "github/copilot.vim",
    event = { "BufNewFile", "BufRead" },
    vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true }),
}
