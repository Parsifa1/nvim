return {
    "ravitemer/mcphub.nvim",
    cmd = "MCPHub",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "bundled_build.lua",
    config = function()
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        require("mcphub").setup {
            use_bundled_binary = true,
        }
    end,
}
