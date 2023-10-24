# my-neovim

我的个人Noevim配置，使用Lazy.nvim作为包管理器，力求高度可定制。

全lua配置，尽量清晰易懂，使用最新的neovim-nightly构建。

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
│   │   │   ├── lsp_signature.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── Mason.lua
│   │   │   ├── neodev.lua
│   │   │   ├── nvim-cmp.lua
│   │   │   └── nvim-lspconfig.lua
│   │   ├── function
│   │   │   ├── aerial.lua
│   │   │   ├── blankline.lua
│   │   │   ├── comment.lua
│   │   │   ├── flash.lua
│   │   │   ├── nvim-autopairs.lua
│   │   │   ├── telescope.lua
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
│   │   │   ├── alpha.lua
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
│   │       └── fzf-native.lua
│   └── snippets
│       └── cpp.lua
└── README.md

9 directories, 45 files
```
