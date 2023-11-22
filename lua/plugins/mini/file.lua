local init = function()

    local go_in_plus = function()
        for _ = 1, vim.v.count1 - 1 do
            MiniFiles.go_in()
        end
        local fs_entry = MiniFiles.get_fs_entry()
        local is_at_file = fs_entry ~= nil and fs_entry.fs_type == 'file'
        MiniFiles.go_in()
        if is_at_file then MiniFiles.close() end
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
            local win_id = args.data.win_id
            vim.api.nvim_win_set_config(win_id, { border = 'rounded' })
        end,
    })

    -- Add multiple keymap
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local map_buf = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, { buffer = args.data.buf_id }) end

            -- Add extra mappings from *MiniFiles-examples*
            map_buf('L', go_in_plus)
            map_buf('<CR>', go_in_plus)
            map_buf('<2-LeftMouse>', go_in_plus)
            map_buf('<Right>', go_in_plus)

            -- map_buf('<BS>', MiniFiles.go_out)
            map_buf('<Left>', MiniFiles.go_out)
            map_buf('<Esc>', MiniFiles.close)
        end,
    })
end

return {
    "echasnovski/mini.files",
    event = "VeryLazy",
    init = init,
    opts = {
        mappings = {
            go_in_plus = '<Space>',
        }

    }
}
