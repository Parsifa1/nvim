return {
    --'navarasu/onedark.nvim',
    "catppuccin/nvim",
    -- "neanias/everforest-nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local colorscheme = 'catppuccin-mocha'
        local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
        if not is_ok then
            vim.notify('colorscheme ' .. colorscheme .. ' not found!')
            return
        end
    end
}
