return {
  'nvim-treesitter/nvim-treesitter',
    opts  = {
        ensure_installed = {"cpp", "lua", "rust", "python"},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
}
