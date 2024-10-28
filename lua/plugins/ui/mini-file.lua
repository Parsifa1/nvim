---@diagnostic disable: undefined-global, unused-local
-- dotfiles show/unsow
local show_dotfiles = false
local filter_show = function(fs_entry)
    return true
end
local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end
local filter_dot = function(fs_entry)
    -- print(show_dotfiles)
    return show_dotfiles and filter_show(fs_entry) or filter_hide(fs_entry)
end
-- custom sort
local custom_sort = function(fs_entries)
    local res = vim.tbl_map(function(x)
        local ext = x.name:match ".+%.(%w+)$" or ""
        return {
            fs_type = x.fs_type,
            name = x.name,
            path = x.path,
            lower_name = x.name:lower(),
            is_dir = x.fs_type == "directory",
            lower_ext = ext:lower(),
        }
    end, fs_entries)

    local function compare_custom(a, b)
        if a.is_dir and not b.is_dir then
            return true
        elseif not a.is_dir and b.is_dir then
            return false
        elseif a.is_dir and b.is_dir then
            return a.lower_name < b.lower_name
        else
            if a.lower_ext == b.lower_ext then
                return a.lower_name < b.lower_name
            else
                return a.lower_ext < b.lower_ext
            end
        end
    end

    table.sort(res, compare_custom)
    return vim.tbl_map(function(x)
        return { name = x.name, fs_type = x.fs_type, path = x.path }
    end, res)
end

local init = function()
    local go_in_plus = function()
        MiniFiles.go_in { close_on_file = true }
    end

    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
            local win_id = args.data.win_id
            vim.api.nvim_win_set_config(win_id, { border = "rounded" })
        end,
    })

    -- Add multiple keymap
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local map_buf = function(lhs, rhs)
                vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
            end

            -- Add extra mappings from *MiniFiles-examples*
            map_buf("L", go_in_plus)
            map_buf("<CR>", go_in_plus)
            map_buf("<Space>", go_in_plus)
            map_buf("<2-LeftMouse>", go_in_plus)
            map_buf("<Right>", go_in_plus)

            map_buf("<Left>", MiniFiles.go_out)
            map_buf("<Esc>", MiniFiles.close)
        end,
    })

    -- show/unsow dotfile and set save keymap
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                MiniFiles.refresh { content = { filter = filter_dot } }
            end
            local buf_id = args.data.buf_id
            vim.keymap.set("n", ".", toggle_dotfiles, { desc = "show dotfiles", buffer = buf_id })
        end,
    })

    -- Create mapping to set current working directory
    local files_set_cwd = function(path)
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.fn.chdir(cur_directory)
        MiniFiles.open()
        MiniFiles.reset()
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
            vim.keymap.set("n", "`", files_set_cwd, { buffer = args.data.buf_id })
            vim.keymap.set({ "n", "i" }, "<C-s>", MiniFiles.synchronize, { buffer = args.data.buf_id })
        end,
    })
end

return {
    "echasnovski/mini.files",
    keys = {
        { "<leader>e", "<cmd>lua MiniFiles.open()<CR>", desc = "file explorer" },
    },
    init = init,
    opts = {
        content = {
            filter = filter_dot,
            sort = custom_sort,
        },
        mappings = {
            go_in_plus = "<CR>",
            reveal_cwd = "",
        },
        options = {
            use_as_default_explorer = true,
        },
        windows = {
            max_number = math.huge,
            -- preview = true,
            width_focus = 50,
            width_nofocus = 15,
            width_preview = 50,
        },
    },
}
