return {
    "3rd/image.nvim",
    event = "VeryLazy",
    enabled = true,
    config = function()
        package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?/init.lua;"
        package.path = package.path .. ";" .. vim.fn.expand "$HOME" .. "/.luarocks/share/lua/5.1/?.lua;"
        require("image").setup {
            backend = "kitty",
        }
    end,
}
