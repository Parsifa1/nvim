return {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    event = "BufRead",
    config = function()
        require'treesitter-context'.setup {
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        }
    end
}
