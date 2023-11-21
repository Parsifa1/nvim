return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    config = function()
        require("project_nvim").setup {
            manual_mode = true,
            telescope_default_action= "cd",
            require('telescope').load_extension('projects')
        }
    end
}
