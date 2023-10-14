return {
    'navarasu/onedark.nvim',
    config = function()
        local colorscheme = 'onedark'
        local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
        if not is_ok then
            vim.notify('colorscheme ' .. colorscheme .. ' not found!')
            return
        end
    end
}
