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
├── LICENSE
├── README.md
├── init.lua
├── lazy-lock.json
├── lua
│   ├── custom.lua
│   ├── faul.lua
│   ├── keymap.lua
│   ├── option.lua
│   ├── plugins
│   │   ├── core
│   │   │   ├── Mason.lua
│   │   │   ├── cmp.lua
│   │   │   ├── conform.lua
│   │   │   ├── lsp.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── neodev.lua
│   │   │   └── treesitter.lua
│   │   ├── dap
│   │   │   ├── dap-ui.lua
│   │   │   ├── dap-virtual-text.lua
│   │   │   ├── dap.lua
│   │   │   └── mason-dap.lua
│   │   ├── edit
│   │   │   ├── comment.lua
│   │   │   ├── flash.lua
│   │   │   ├── nvim-surround.lua
│   │   │   ├── treesitter-textobjects.lua
│   │   │   └── vim-targets.lua
│   │   ├── git
│   │   │   ├── flog.lua
│   │   │   ├── fugitive.lua
│   │   │   ├── gist.lua
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── others
│   │   │   ├── cellular-automaton.lua
│   │   │   ├── filetype.lua
│   │   │   ├── friendly-snippets.lua
│   │   │   ├── markdown-preview.lua
│   │   │   ├── markdown-typmath.lua
│   │   │   ├── node_modules
│   │   │   ├── typst-preview.lua
│   │   │   ├── typst.lua
│   │   │   ├── vim-astro.lua
│   │   │   └── yarn.lock
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   ├── nightfox.lua
│   │   │   └── onedark.lua
│   │   ├── tools
│   │   │   ├── asynctasks.lua
│   │   │   ├── compatitest.lua
│   │   │   ├── copilot.lua
│   │   │   ├── flatten.lua
│   │   │   ├── gp.lua
│   │   │   ├── hbac.lua
│   │   │   ├── leetcode.lua
│   │   │   ├── mundo.lua
│   │   │   ├── neovim-autopair.lua
│   │   │   ├── oil.lua
│   │   │   ├── sleuth.lua
│   │   │   ├── suda.lua
│   │   │   ├── telescope.lua
│   │   │   ├── todo-comments.lua
│   │   │   ├── trouble.lua
│   │   │   ├── which-key.lua
│   │   │   └── workspace.lua
│   │   └── ui
│   │       ├── alpha.lua
│   │       ├── blankline.lua
│   │       ├── dropbar.lua
│   │       ├── edgy.lua
│   │       ├── fidget.lua
│   │       ├── lualine.lua
│   │       ├── mini-file.lua
│   │       ├── noice.lua
│   │       ├── nvim-colorizer.lua
│   │       ├── nvim-notify.lua
│   │       ├── nvim-ufo.lua
│   │       ├── outline.lua
│   │       ├── rainbow-delimiters.lua
│   │       ├── statuscol.lua
│   │       ├── tint.lua
│   │       └── toggleterm.lua
│   ├── snippets
│   │   ├── cpp.lua
│   │   └── rust.lua
│   └── user
│       ├── autosave.lua
│       ├── coderunner.lua
│       ├── floaterm.lua
│       ├── init.lua
│       └── readonly.lua
├── stylua.toml
└── tasks.ini

14 directories, 86 files
```
测试
