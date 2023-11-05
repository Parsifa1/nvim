# my-neovim

我的个人Noevim配置，使用Lazy.nvim作为包管理器，力求高度可定制。

全lua配置，尽量清晰易懂，使用最新的neovim-nightly构建。

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/image.png)

# Data Structure

```
.
├── init.lua
├── lazy-lock.json
├── lua
│   ├── custom.lua
│   ├── keymap.lua
│   ├── option.lua
│   ├── plugins
│   │   ├── core
│   │   │   ├── cmp-buffer.lua
│   │   │   ├── cmp-cmdline.lua
│   │   │   ├── cmp-nvim-lsp.lua
│   │   │   ├── cmp-path.lua
│   │   │   ├── conform.lua
│   │   │   ├── lsp-notify.lua
│   │   │   ├── lsp_signature.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── mason-installer.lua
│   │   │   ├── Mason.lua
│   │   │   ├── neodev.lua
│   │   │   ├── nvim-cmp.lua
│   │   │   └── nvim-lspconfig.lua
│   │   ├── function
│   │   │   ├── comment.lua
│   │   │   ├── flash.lua
│   │   │   ├── vim-repeat.lua
│   │   │   ├── vim-surround.lua
│   │   │   ├── vim-targets.lua
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── flog.lua
│   │   │   ├── fugitive.lua
│   │   │   ├── gist.lua
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   └── neogit.lua
│   │   ├── interface
│   │   │   ├── aerial.lua
│   │   │   ├── alpha.lua
│   │   │   ├── blankline.lua
│   │   │   ├── colorscheme.lua
│   │   │   ├── dropbar.lua
│   │   │   ├── floaterm.lua
│   │   │   ├── lualine.lua
│   │   │   ├── neo-tree.lua
│   │   │   ├── nvim-notify.lua
│   │   │   └── treesitter.lua
│   │   └── others
│   │       ├── compatitest.lua
│   │       ├── copilot.lua
│   │       ├── filetype.lua
│   │       ├── fzf-native.lua
│   │       ├── markdown-preview.lua
│   │       ├── node_modules
│   │       ├── nvim-autopairs.lua
│   │       ├── telescope.lua
│   │       ├── tmux-navigator.lua
│   │       └── yarn.lock
│   └── snippets
│       └── cpp.lua
└── README.md

10 directories, 51 files

9 directories, 45 files
```
