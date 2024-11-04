---@type LazyPluginSpec

return {
    "mistricky/codesnap.nvim",
    cmd = { "CodeSnap", "CodeSnapSave" },
    enabled = vim.uv.os_uname().sysname == "Windows_NT",
    build = "make",
    opts = {
        save_path = "/mnt/e/Aldric/Desktop/",
        code_font_family = "IosevkaCloudtide Nerd Font",
        bg_theme = "summer",
    },
}
