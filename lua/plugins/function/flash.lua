--@author: Parsifa1
local function flash_set(need)
	return function()
		require("flash")[need]()
	end
end

return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		label = {
			uppercase = false,
		},
		modes = {
			char = { enabled = false },
			treesitter = {
				highlight = { backdrop = true },
			},
		},
	},

	keys = {
		{ "f", mode = { "n", "x", "o" }, flash_set("jump"), desc = "Flash" },
		{ "s", mode = { "n", "x", "o" }, flash_set("treesitter"), desc = "Flash Treesitter" },
		{ "r", mode = "o", flash_set("remote"), desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, flash_set("treesitter_search"), desc = "Treesitter Search" },
	},
}
