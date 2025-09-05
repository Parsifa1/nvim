---@type LazyPluginSpec

return {
  {
    "parsifa1/markdown-preview.nvim",
    ft = { "markdown" },
    build = ":cal mkdp#util#install()",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
  },
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    ft = { "markdown" },
    config = function()
      require("luasnip-latex-snippets").setup {
        allow_on_markdown = true,
        use_treesitter = true,
      }
      local ls = require "luasnip"
      local t = ls.text_node
      local i = ls.insert_node
      local utils = require "luasnip-latex-snippets.util.utils"
      local not_math = utils.with_opts(utils.not_math, true) -- true to use treesitter

      -- set a higher priority (defaults to 0 for most snippets)
      local dm = ls.snippet(
        { trig = "dm", name = "Math", condition = utils.pipe { not_math }, priority = 10 },
        { t { "$$", "" }, i(0), t { " ", "" }, t { "$$", "" } }
      )
      local mk = ls.snippet(
        { trig = "mk", name = "Math inline", condition = utils.pipe { not_math }, priority = 10 },
        { t { "$" }, i(0), t { "$" } }
      )
      local rd = ls.parser.parse_snippet(
        { trig = "rd", name = "to the ... power ^{}", utils.pipe { not_math }, priority = 10 },
        "^{$1}$0 "
      )
      ls.add_snippets("markdown", { dm, mk, rd }, { type = "autosnippets" })
    end,
  },
}
