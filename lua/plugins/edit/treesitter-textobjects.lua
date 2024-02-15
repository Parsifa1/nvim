return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPre",
    cond = vim.bo.filetype ~= "alpha",
    config = function()
        require("nvim-treesitter.configs").setup {
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
                        ["al"] = { query = "@loop.outer", desc = "a loop" },
                        ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v", -- charwise
                        ["@function.outer"] = "V", -- linewise
                        ["@class.outer"] = "<c-v>", -- blockwise
                    },
                    include_surrounding_whitespace = false,
                },
            },
        }
    end,
}
