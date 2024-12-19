return {
    "3rd/image.nvim",
    enabled = vim.fn.hostname() ~= "debian",
    -- enabled = false,
    ft = { "markdown", "typst" },
    config = function()
        require("image").setup {
            backend = "kitty",
            integrations = {
                markdown = {
                    only_render_image_at_cursor = true
                },
                typst = {
                    only_render_image_at_cursor = true
                }
            }
        }
    end,
}
