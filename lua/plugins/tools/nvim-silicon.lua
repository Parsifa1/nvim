return {
    "michaelrommel/nvim-silicon",
    enabled = vim.fn.hostname() ~= "debian",
    cmd = "Silicon",
    main = "nvim-silicon",
    keys = {
        {
            "<leader>sc",
            function() require("nvim-silicon").clip() end,
            mode = { "n", "v" },
            desc = "Copy code screenshot to clipboard",
        },
    },
    opts = {
        -- Configuration here, or leave empty to use defaults
        line_offset = function(args) return args.line1 end,
        wslclipboard = "auto",
        font = "Iosevka Cloudtide; LXGW WenKai",
    },
}
