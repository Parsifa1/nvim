---@type LazyPluginSpec
return {
    "github/copilot.vim",
    event = { "BufNewFile", "BufReadPost" },
    vim.api.nvim_set_keymap("i", "<C-CR>", 'copilot#Accept("<CR>")', { silent = true, expr = true }),
}
