return {
    "parsifa1/smart-tab",
    dev = true,
    event = "InsertEnter",
    config = function()
        require("smart-tab").setup {
            skips = { "string_content" },
            mapping = "<tab>",
            exclude_filetypes = {},
        }
    end,
}
