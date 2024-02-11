return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "cpp",
                "lua",
                "rust",
                "python",
                "markdown",
                "vim",
                "regex",
                "bash",
                "markdown_inline",
                "comment",
                "org",
                "yaml",
                "fish",
                "html",
                "javascript",
                "typescript",
                "latex",
            },
            sync_install = true,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end,
}
