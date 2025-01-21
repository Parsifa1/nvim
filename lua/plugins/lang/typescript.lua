local mason_path = vim.fn.stdpath "data" .. "/mason/packages/"
local ft = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "markdown.mdx" }

return {
    -- TODO: waiting pr to merge
    "parsifa1/typescript-tools.nvim",
    -- dir = "~/Project/typescript-tools.nvim",
    ft = ft,
    -- enabled = false,
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        filetypes = ft,
        settings = {
            tsserver_plugins = {
                {
                    name = "@vue/typescript-plugin",
                    path = mason_path .. "vue-language-server" .. "/node_modules/@vue/language-server",
                },
                {
                    name = "@mdxjs/typescript-plugin",
                    path = mason_path .. "mdx-analyzer" .. "/node_modules/@mdx/language-server",
                },
            },
        },
    },
}
