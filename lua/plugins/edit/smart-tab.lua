return {
    "parsifa1/smart-tab.nvim",
    dir = vim.fn.stdpath "config" .. "/lua/users/smart-tab",
    event = "InsertEnter",
    config = function()
        require("smart-tab").setup {
            skips = { "string_content" },
            mapping = "<tab>",
            exclude_filetypes = {},
        }
    end,
}
