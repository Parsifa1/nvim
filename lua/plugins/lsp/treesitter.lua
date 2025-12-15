local function add_textobject(mp)
  for lhs, obj in pairs(mp) do
    vim.keymap.set(
      { "x", "o" },
      lhs,
      function() require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects") end
    )
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    event = "User AfterFile",
    cmd = { "TSUpdate", "TSInstall", "TSInstallInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "cpp",
        "lua",
        "rust",
        "python",
        "vim",
        "regex",
        "bash",
        "markdown_inline",
        "comment",
        "yaml",
        "json",
        "jsonc",
        "latex",
        "markdown",
        "fish",
        "html",
        "css",
        "tsx",
        "javascript",
        "typescript",
        "nix",
        "typst",
        "vue",
        "astro",
        "vimdoc",
        "koka",
      },
    },
    config = function(_, opts)
      -- add additional ts-lib
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").koka = {
            install_info = {
              url = "https://github.com/mtoohey31/tree-sitter-koka",
              queries = "queries", -- also install queries from given directory
            },
          }
        end,
      })
      require("nvim-treesitter").install(opts.ensure_installed)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = { lookahead = true, include_surrounding_whitespace = false },
      }
      -- Define text objects
      add_textobject {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ii"] = "@conditional.inner",
        ["ai"] = "@conditional.outer",
        ["ar"] = "@return.outer",
        ["ir"] = "@return.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "astro", "html", "javascriptreact", "typescriptreact", "vue" },
    opts = true,
  },
}
