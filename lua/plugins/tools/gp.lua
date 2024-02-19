return {
    "robitx/gp.nvim",
    cmd = {
        "GpChatNew",
        "GpChatToggle",
        "GpRewrite",
    },
    -- enabled = false,
    config = function()
        require("gp").setup {
            openai_api_endpoint = "https://cfcus02.opapi.win/v1/chat/completions",
            openai_api_key = { "cat", "/home/parsifa1/Public/openai_api_key" },
        }
    end,
}
