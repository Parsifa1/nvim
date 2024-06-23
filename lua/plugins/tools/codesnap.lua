return {
    "mistricky/codesnap.nvim",
    enabled = vim.uv.os_uname().sysname == "Linux",
    build = "make",
    opts = {
        save_path = "/mnt/e/Aldric/Desktop/",
        code_font_family = "Iosevka Cloudtide",
        bg_theme = "summer",
    },
}
