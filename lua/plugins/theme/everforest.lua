return {
    "neanias/everforest-nvim",
    lazy = true,
    config = function ()
	require("everforest").setup({
        italics = true,
	})
    end
}
