return {
    "stevearc/dressing.nvim",
      init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = {
        select = {
            backend = { "builtin", "nui", "telescope" },
            get_config = function(opts)
                if opts.kind == "codeaction" then
                    return {
                        builtin = {
                            relative = "cursor",
                            max_width = 50,
                        },
                    }
                end
            end,
            builtin = {
                min_width = 70,
                mappings = {
                    ["q"] = "Close",
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                },
            },
        },
    },
}
