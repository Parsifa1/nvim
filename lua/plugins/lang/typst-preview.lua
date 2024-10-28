---@type LazyPluginSpec
---@diagnostic disable: unused-local

return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {
        debug = false,
        dependencies_bin = {
            ["tinymist"] = "tinymist",
            ["websocat"] = "websocat",
        },
        -- get_root = function(bufnr_of_typst_buffer)
        --     return vim.fn.fnamemodify(vim.fn.expand "%:p", ":h")
        -- end,
    },
}
