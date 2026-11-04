return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    picker = "default",
    enable_builtin = true,
  },
  keys = {
    {
      "<leader>gi",
      "<CMD>Octo issue list<CR>",
      desc = "List GitHub Issues",
    },
    {
      "<leader>gp",
      "<CMD>Octo pr list<CR>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>gn",
      "<CMD>Octo notification list<CR>",
      desc = "List GitHub Notifications",
    },
    {
      "<leader>gs",
      function() require("octo.utils").create_base_search_command { include_current_repo = true } end,
      desc = "Search GitHub",
    },
  },
}
