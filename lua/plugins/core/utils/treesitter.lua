return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufNewFile", "BufReadPre" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").prefer_git = true
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
                "yaml",
                "fish",
                "html",
                "javascript",
                "typescript",
                "latex",
                "nix",
                "typst",
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
