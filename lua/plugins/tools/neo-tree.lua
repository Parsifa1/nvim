local custom = require("custom")
local kinds = vim.iter(custom.icons.kind):fold({}, function(t, k, v)
	t[k] = { icon = v }
	return t
end)

local opts = {
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
	default_source = "last",
	popup_border_style = custom.border,
	default_component_configs = {
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
	},
	source_selector = {
		winbar = true,
		sources = {
			{
				source = "filesystem",
				display_name = "  File",
			},
			{
				source = "buffers",
				display_name = "  Buff ",
			},
			{
				source = "git_status",
				display_name = "  Git ",
			},
			-- {
			-- 	source = "document_symbols",
			-- 	display_name = "  Symbols",
			-- },
		},
	},
	window = {
		width = custom.width,
		mappings = {
			["<Space>"] = "open",
			["o"] = "system_open",
			["h"] = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" and node:is_expanded() then
					require("neo-tree.sources.filesystem").toggle_directory(state, node)
				else
					require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
				end
			end,
			["l"] = function(state)
				local node = state.tree:get_node()
				if node.type == "directory" then
					if not node:is_expanded() then
						require("neo-tree.sources.filesystem").toggle_directory(state, node)
					elseif node:has_children() then
						require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
					end
				end
			end,

			-- Swap default split behavior
			["S"] = "open_vsplit",
			["s"] = "open_split",
		},
	},
	commands = {
		system_open = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			vim.ui.open(path)
		end,
	},
	filesystem = {
		filtered_items = {
			hide_gitignored = false,
			hide_by_name = {
				"code.code-workspace",
				"compile_flags.txt",
                "LICENSE",
                "lazy-lock.json"
			},
			always_show = {
				".config",
			},
		},
		group_empty_dirs = true,
		follow_current_file = {
			enabled = true,
		},
		window = {
			mappings = {
				["[g"] = "none",
				["]g"] = "none",
				["[h"] = "prev_git_modified",
				["]h"] = "next_git_modified",
			},
		},
	},
	document_symbols = {
		kinds = kinds,
	},
}

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "main",
    event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"s1n7ax/nvim-window-picker",
	},
	opts = opts,
}
