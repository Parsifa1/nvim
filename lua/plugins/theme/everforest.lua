return {
    "neanias/everforest-nvim",
    lazy = true,
    config = function ()
	require("everforest").setup({
        italics = true,
        transparent_background_level = 1,
	})
    end
}
