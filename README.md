# my-neovim

我的个人Noevim配置，使用Lazy.nvim作为包管理器，力求高度可定制。

全lua配置，尽量清晰易懂，使用最新的neovim-nightly构建。

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/image.png)

+ LSP
+ Tree-sitter
+ CMP

# Data Structure

```
.
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── custom.lua
│   ├── faul.lua
│   ├── keymap.lua
│   ├── option.lua
│   ├── plugins
│   │   ├── core
│   │   │   ├── init.lua
│   │   │   ├── lsp
│   │   │   │   ├── markdown-preview.lua
│   │   │   │   ├── markdown-typmath.lua
│   │   │   │   ├── rustacean.lua
│   │   │   │   └── typst-preview.lua
│   │   │   └── utils
│   │   │       ├── cmp.lua
│   │   │       ├── lsp.lua
│   │   │       ├── luasnip.lua
│   │   │       ├── mason.lua
│   │   │       └── treesitter.lua
│   │   ├── dap
│   │   │   ├── dap.lua
│   │   │   ├── dap-ui.lua
│   │   │   ├── dap-virtual-text.lua
│   │   │   └── mason-dap.lua
│   │   ├── edit
│   │   │   ├── comment.lua
│   │   │   ├── flash.lua
│   │   │   ├── nvim-surround.lua
│   │   │   ├── treesitter-textobjects.lua
│   │   │   ├── vim-targets.lua
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── init.lua
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   ├── nightfox.lua
│   │   │   └── onedark.lua
│   │   ├── tools
│   │   │   ├── asynctasks.lua
│   │   │   ├── autopair.lua
│   │   │   ├── codesnap.lua
│   │   │   ├── compatitest.lua
│   │   │   ├── conform.lua
│   │   │   ├── copilot.lua
│   │   │   ├── direnv.lua
│   │   │   ├── dressing.lua
│   │   │   ├── flatten.lua
│   │   │   ├── fzf.lua
│   │   │   ├── gp.lua
│   │   │   ├── image.lua
│   │   │   ├── leetcode.lua
│   │   │   ├── neorg.lua
│   │   │   ├── oil.lua
│   │   │   ├── restore_view.lua
│   │   │   ├── sleuth.lua
│   │   │   ├── suda.lua
│   │   │   ├── telescope.lua
│   │   │   ├── todo-comments.lua
│   │   │   ├── trouble.lua
│   │   │   ├── wakatime.lua
│   │   │   └── workspace.lua
│   │   └── ui
│   │       ├── alpha.lua
│   │       ├── dropbar.lua
│   │       ├── edgy.lua
│   │       ├── fidget.lua
│   │       ├── incline.lua
│   │       ├── indent-blankline.lua
│   │       ├── lualine.lua
│   │       ├── mini-file.lua
│   │       ├── noice.lua
│   │       ├── nvim-colorizer.lua
│   │       ├── nvim-notify.lua
│   │       ├── nvim-ufo.lua
│   │       ├── outline.lua
│   │       ├── rainbow-delimiters.lua
│   │       ├── simple-usage.lua
│   │       ├── statuscol.lua
│   │       └── toggleterm.lua
│   ├── snippets
│   │   ├── cpp.lua
│   │   └── typst.lua
│   └── user
│       ├── autocmd.lua
│       ├── coderunner.lua
│       ├── floaterm.lua
│       ├── init.lua
│       └── lsp.lua
├── README.md
├── stylua.toml
└── tasks.ini

14 directories, 86 files
```
