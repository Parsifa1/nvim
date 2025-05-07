---@diagnostic disable: missing-fields
local ensure_installed = {
    "cpp",
    "lua",
    "rust",
    "python",
    "vim",
    "regex",
    "bash",
    "markdown_inline",
    "comment",
    "yaml",
    "latex",
    "markdown",
    "fish",
    "html",
    "css",
    "javascript",
    "typescript",
    "nix",
    "typst",
    "vue",
    "astro",
    "vimdoc",
}
local auto_tag = {
    "windwp/nvim-ts-autotag",
    ft = { "astro", "html", "javascriptreact", "typescriptreact", "vue" },
    opts = true,
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "RRethy/nvim-treesitter-textsubjects",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = { "BufNewFile", "BufRead" },
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup {
            auto_install = true,
            ensure_installed = ensure_installed,
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = false,
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
                        ["ii"] = "@conditional.inner", -- as for 'if'
                        ["ai"] = "@conditional.outer",
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
            textsubjects = {
                enable = true,
                prev_selection = ",",
                keymaps = {
                    ["."] = "textsubjects-smart",
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

return { treesitter, auto_tag }
