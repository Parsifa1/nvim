return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    init = function()
        function _ADD_CURR_DIR_TO_PROJECTS()
            local historyfile = require("project_nvim.utils.path").historyfile
            local curr_directory = vim.fn.expand("%:p:h")
            vim.cmd("!echo " .. curr_directory .. " >> " .. historyfile)
        end
        vim.cmd("command! ProjectAdd lua _ADD_CURR_DIR_TO_PROJECTS()")
    end,
    config = function()
        require("project_nvim").setup {
            manual_mode = true,
            -- telescope_default_action= "cd",
            require('telescope').load_extension('projects')
        }
    end
}
