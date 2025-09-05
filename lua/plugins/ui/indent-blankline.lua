return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "User AfterFile",
    opts = {
        indent = { char = "│" },
        debounce = 50,
        scope = { enabled = false },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.ACTIVE, function(_)
            local unuse = { "oil" } -- filetype that should not use indent-blankline
            return not vim.tbl_contains(unuse, vim.bo.filetype)
        end)
    end,
}
