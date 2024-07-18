return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-textsubjects", "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufNewFile", "BufReadPre" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo " },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup {
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            auto_install = true,
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
                "css",
                "javascript",
                "typescript",
                "latex",
                "nix",
                "typst",
                "vue",
                "astro",
                "vimdoc",
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["aa"] = { query = "@parameter.outer", desc = "a argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "inner part of a argument" },
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["id"] = "@conditional.inner",
                        ["ad"] = "@conditional.outer",
                        ["ar"] = { query = "@return.outer", desc = "a return" },
                        ["ir"] = { query = "@return.outer", desc = "inner return" },
                        -- ["al"] = { query = "@loop.outer", desc = "a loop" },
                        -- ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
            },
            textsubjects = {
                enable = true,
                prev_selection = ",",
                keymaps = {
                    ["<CR>"] = "textsubjects-smart",
                    [";"] = "textsubjects-container-outer",
                    ["i;"] = {
                        "textsubjects-container-inner",
                        desc = "Select inside containers (classes, functions, etc.)",
                    },
                },
            },
        }
    end,
}
