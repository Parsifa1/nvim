return {
    "nvim-telescope/telescope-project.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function()
        -- require 'telescope'.extensions.project.project {}
        require'telescope'.load_extension('project')
    end
}
