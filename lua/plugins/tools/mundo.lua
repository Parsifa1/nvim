---@type LazyPluginSpec
return {
    "simnalamburt/vim-mundo",
    event = "VimEnter",
    cmd = "MundoToggle",
    keys = { { "<leader>u", "<cmd>MundoToggle<CR>", desc = "undo tree" } },
}
