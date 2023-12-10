# my-neovim

我的个人Noevim配置，使用Lazy.nvim作为包管理器，力求高度可定制。

全lua配置，尽量清晰易懂，使用最新的neovim-nightly构建。

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/image.png)

# Data Structure

```
.
├── init.lua
├── lazy-lock.json
├── LICENSE
├── lua
│   ├── custom.lua
│   ├── keymap.lua
│   ├── option.lua
│   ├── plugin.lua
│   ├── plugins
│   │   ├── core
│   │   │   ├── conform.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── Mason.lua
│   │   │   ├── neodev.lua
│   │   │   ├── nvim-cmp.lua
│   │   │   ├── nvim-lsp.lua
│   │   │   └── treesitter.lua
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
│   │   │   └── vim-targets.lua
│   │   ├── git
│   │   │   ├── flog.lua
│   │   │   ├── fugitive.lua
│   │   │   ├── gist.lua
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── mini
│   │   │   └── file.lua
│   │   ├── others
│   │   │   ├── filetype.lua
│   │   │   ├── friendly-snippets.lua
│   │   │   ├── fzf-native.lua
│   │   │   ├── markdown-preview.lua
│   │   │   ├── node_modules
│   │   │   ├── typst.lua
│   │   │   ├── typst-preview.lua
│   │   │   └── yarn.lock
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   └── onedark.lua
│   │   ├── tools
│   │   │   ├── aerial.lua
│   │   │   ├── asynctasks.lua
│   │   │   ├── compatitest.lua
│   │   │   ├── copilot.lua
│   │   │   ├── karen-yank.lua
│   │   │   ├── neo-tree.lua
│   │   │   ├── oil.lua
│   │   │   ├── orgmode.lua
│   │   │   ├── project.lua
│   │   │   ├── suda.lua
│   │   │   ├── telescope.lua
│   │   │   ├── todo-comments.lua
│   │   │   ├── trouble.lua
│   │   │   ├── ultimate-autopair.lua
│   │   │   └── which-key.lua
│   │   └── ui
│   │       ├── alpha.lua
│   │       ├── blankline.lua
│   │       ├── dropbar.lua
│   │       ├── edgy.lua
│   │       ├── lualine.lua
│   │       ├── noice.lua
│   │       ├── nvim-notify.lua
│   │       ├── rainbow-delimiters.lua
│   │       └── toggleterm.lua
│   ├── snippets
│   │   └── cpp.lua
│   └── user
│       ├── coderunner.lua
│       ├── floatwin.lua
│       └── init.lua
├── README.md
└── tasks.ini

15 directories, 71 files
```
