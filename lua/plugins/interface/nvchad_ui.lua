return {
    'NvChad/ui',
    config = function () {

        statusline = {
            theme = "default", -- default/vscode/vscode_colored/minimal

            -- default/round/block/arrow (separators work only for "default" statusline theme;
            -- round and block will work for the minimal theme only)
            separator_style = "default",
            overriden_modules = nil,
        },
    }
        
    end
}
