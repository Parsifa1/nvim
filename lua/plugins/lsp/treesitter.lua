local function add_textobject(lhs, obj)
    vim.keymap.set({ "x", "o" }, lhs, function()
        require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
    end)
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        event = { "BufNewFile", "BufRead" },
        cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
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
                "json",
                "jsonc",
                "latex",
                "markdown",
                "fish",
                "html",
                "css",
                "tsx",
                "javascript",
                "typescript",
                "nix",
                "typst",
                "vue",
                "astro",
                "vimdoc",
                "koka",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter").setup {}
            -- spawn all treesitter
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = "*",
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
            -- add additional ts-lib
            vim.api.nvim_create_autocmd("User", {
                pattern = "TSUpdate",
                callback = function()
                    require("nvim-treesitter.parsers").koka = {
                        install_info = {
                            url = "https://github.com/mtoohey31/tree-sitter-koka",
                            queries = "queries", -- also install queries from given directory
                        },
                    }
                end,
            })
            require("nvim-treesitter").install(opts.ensure_installed)
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = { lookahead = true, include_surrounding_whitespace = false },
            }
            -- Define text objects
            add_textobject("aa", "@parameter.outer")
            add_textobject("ia", "@parameter.inner")
            add_textobject("af", "@function.outer")
            add_textobject("if", "@function.inner")
            add_textobject("ac", "@class.outer")
            add_textobject("ic", "@class.inner")
            add_textobject("ii", "@conditional.inner")
            add_textobject("ai", "@conditional.outer")
            add_textobject("ar", "@return.outer")
            add_textobject("ir", "@return.inner")
            add_textobject("al", "@loop.outer")
            add_textobject("il", "@loop.inner")
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        ft = { "astro", "html", "javascriptreact", "typescriptreact", "vue" },
        opts = true,
    },
}
