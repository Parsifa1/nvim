return {
    "robitx/gp.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("gp").setup {
            openai_api_key = { "cat", "/home/parsifa1/Public/openai_api_key" },
        }
    end,
}
