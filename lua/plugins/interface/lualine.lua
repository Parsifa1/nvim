return {
    'nvim-lualine/lualine.nvim',

    config = function ()
        -- local nvim_tree_shift =  {
        --     -- function ()
        --     --     return string.rep(' ',
        --     --     vim.api.nvim_win_get_width(require'nvim-tree.view'.get_winnr()) - 1)
        --     -- end,
        --     -- cond = require('nvim-tree.view').is_visible,
        --     -- color = 'NvimTreeNormal'
        -- }

        require'lualine'.setup {
            -- sections = {
            --     lualine_a = { nvim_tree_shift, "mode" }
            -- },
            tabline = {  -- If you want tabline to shift too
                lualine_a = { "buffers" }
            }
        }
    end
}
