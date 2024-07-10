---@type LazyPluginSpec
---@diagnostic disable: unused-local

return {
    "parsifa1/typst-preview.nvim",
    ft = "typst",
    build = function()
        require("typst-preview").update()
    end,
    opts = {
        debug = false,
        dependencies_bin = {
            ["typst-preview"] = "tinymist",
            ["websocat"] = "websocat",
        },
        get_root = function(bufnr_of_typst_buffer)
            return vim.fn.fnamemodify(vim.fn.expand "%:p", ":h")
        end,
    },
}
