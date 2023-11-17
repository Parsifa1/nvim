return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = {
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		bottom = {
			"Trouble",
			{ ft = "qf", title = "QuickFix" },
			{
				ft = "help",
				size = { height = 20 },
				-- only show help buffers
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
			{ ft = "spectre_panel", size = { height = 0.4 } },
		},
		right = {
			{
				ft = "aerial",
				title = "aerial",
				open = "AerialOpen",
				pinned = "ture",
			},
		},
		-- left = {
		-- 	-- Neo-tree filesystem always takes half the screen height
		-- 	{
		-- 		title = "Neo-Tree",
		-- 		ft = "neo-tree",
		-- 		filter = function(buf)
		-- 			return vim.b[buf].neo_tree_source == "filesystem"
		-- 		end,
		-- 		size = { height = 0.5 },
		-- 	},
		-- 	{
		-- 		title = "Neo-Tree Git",
		-- 		ft = "neo-tree",
		-- 		filter = function(buf)
		-- 			return vim.b[buf].neo_tree_source == "git_status"
		-- 		end,
		-- 		pinned = true,
		-- 		open = "Neotree position=right git_status",
		-- 	},
		-- 	{
		-- 		title = "Neo-Tree Buffers",
		-- 		ft = "neo-tree",
		-- 		filter = function(buf)
		-- 			return vim.b[buf].neo_tree_source == "buffers"
		-- 		end,
		-- 		pinned = true,
		-- 		open = "Neotree position=top buffers",
		-- 	},
		-- },
	},
}
