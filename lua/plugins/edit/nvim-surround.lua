return {
  "kylechui/nvim-surround",
  event = "User AfterFile",
  config = function()
    require("nvim-surround").setup {
      -- Configuration here, or leave empty to use defaults
    }
  end,
}
