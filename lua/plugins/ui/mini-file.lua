---@diagnostic disable: missing-parameter, unused-local
local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
end

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

            map_buf('<Left>', MiniFiles.go_out)
            map_buf('<Esc>', MiniFiles.close)
        end,
    })

    --show/unsow dotfile
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local show_dotfiles = false
            local filter_show = function(fs_entry) return true end
            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                MiniFiles.refresh({ content = { filter = new_filter } })
            end
            local buf_id = args.data.buf_id
            vim.keymap.set('n', '<Tab>', toggle_dotfiles, { desc = "show dotfiles", buffer = buf_id })
        end,
    })

    -- Create mapping to set current working directory
    local files_set_cwd = function(path)
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
        MiniFiles.open()
        MiniFiles.reset()
    end
    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            vim.keymap.set('n', '`', files_set_cwd, { buffer = args.data.buf_id })
        end,
    })
end

return {
    "echasnovski/mini.files",
    event = "VeryLazy",
    init = init,
    opts = {
        content = {
            filter = filter_hide
        },
        mappings = {
            go_in_plus = '<Space>',
            reveal_cwd = '',
        },
        windows = {
            max_number = math.huge,
            -- preview = true,
            width_focus = 50,
            width_nofocus = 15,
            width_preview = 50,
        },
    }
}
