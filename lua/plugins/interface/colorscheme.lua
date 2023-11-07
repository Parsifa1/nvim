return {
    "catppuccin/nvim",
    dependencies = {
    'navarasu/onedark.nvim',
    "neanias/everforest-nvim",
    },
    name = "catppuccin",
    priority = 1000,
    config = function()
        local colorscheme = 'catppuccin'
        local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
        if not is_ok then
            vim.notify('colorscheme ' .. colorscheme .. ' not found!')
            return
        end
    end
}
