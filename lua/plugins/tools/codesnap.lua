---@type LazyPluginSpec

return {
    "jhonnyV-V/codesnap.nvim",
    branch = "feature/wsl-copy-to-clipboard",
    cmd = { "CodeSnap", "CodeSnapSave" },
    enabled = vim.uv.os_uname().sysname == "Linux",
    build = "make",
    opts = {
        save_path = "/mnt/e/Aldric/Desktop/",
        code_font_family = "Iosevka Cloudtide",
        bg_theme = "summer",
    },
}
