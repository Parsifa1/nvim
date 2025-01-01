---@diagnostic disable: undefined-global, unused-local, duplicate-set-field
-- dotfiles show/unsow
local show_dotfiles = false
-- filter dotfiles
local filter_dot = function(fs_entry)
    local filter_show = function()
        return true
    end
    local filter_hide = function()
        return not vim.startswith(fs_entry.name, ".")
    end
    -- print(show_dotfiles)
    return show_dotfiles and filter_show() or filter_hide()
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
-- map split
local map_split = function(buf_id, lhs, direction)
    local rhs = function()
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
        end)

        vim.defer_fn(function()
            MiniFiles.set_target_window(new_target_window)
            MiniFiles.go_in()
            MiniFiles.close()
        end, 30)
    end

    -- Adding `desc` will result into `show_help` entries
    local split_direction = vim.split(direction, " ")[2]
    local desc = "Open in " .. split_direction .. " split"
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end
-- Create mapping to set current working directory
local files_set_cwd = function(path)
    local cur_entry_path = MiniFiles.get_fs_entry().path
    local cur_directory = vim.fs.dirname(cur_entry_path)
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.fn.chdir(cur_directory)
    MiniFiles.open()
    MiniFiles.reset()
end

local command = function()
    local this = vim.api.nvim_buf_get_name(0)
    local cmd = vim.fn.filereadable(this) == 1 and MiniFiles.open or MiniFiles.open
    cmd()
    MiniFiles.reveal_cwd()
end

local init = function()
    local go_in_plus = function()
        MiniFiles.go_in { close_on_file = true }
    end

    -- Add border to MiniFiles window
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
            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                MiniFiles.refresh { content = { filter = filter_dot } }
            end
            local buf_id = args.data.buf_id
            -- show/unsow dotfile and set save keymap
            vim.keymap.set("n", ".", toggle_dotfiles, { desc = "show dotfiles", buffer = buf_id })

            -- Add extra mappings from *MiniFiles-examples*
            map_buf("L", go_in_plus)
            map_buf("<CR>", go_in_plus)
            map_buf("<Space>", go_in_plus)
            map_buf("<2-LeftMouse>", go_in_plus)
            map_buf("<Right>", go_in_plus)
            map_buf("<Left>", MiniFiles.go_out)
            map_buf("<Esc>", MiniFiles.close)
            map_split(buf_id, "zs", "belowright horizontal")
            map_split(buf_id, "zv", "belowright vertical")
            vim.keymap.set("n", "`", files_set_cwd, { buffer = args.data.buf_id })
            vim.keymap.set({ "n", "i" }, "<C-s>", MiniFiles.synchronize, { buffer = args.data.buf_id })
        end,
    })
    -- Enpowerd lsp rename
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
            Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
    })
end

return {
    {
        "echasnovski/mini.files",
        keys = {
            { "<leader>e", command, desc = "file explorer" },
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
    },
    {
        "echasnovski/mini.icons",
        specs = { { "nvim-tree/nvim-web-devicons", enabled = false, optional = true } },
        opts = {
            extension = {
                ["db"] = { glyph = "󰆼", hl = "MiniIconsGrey" },
                ["mdx"] = { glyph = "󰍔", hl = "MiniIconsGrey" },
                ["mbt"] = { glyph = "󱩡", hl = "MiniIconsPurple" },
            },
            filetype = {
                ["moonbit"] = { glyph = "󱩡", hl = "MiniIconsPurple" },
            },
            file = {
                ["devenv.lock"] = { glyph = "", hl = "MiniIconsGrey" },
            },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}
