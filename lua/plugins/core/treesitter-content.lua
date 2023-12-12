return {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    config = function()
        require'treesitter-context'.setup {
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        }
    end
}
