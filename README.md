# my-neovim

My personal Noevim configuration, using Lazy.nvim as the package manager, strives to be highly customizable.   

Full lua configuration, built using the latest neovim-nightly.

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/neovim.png)

Startup Time:
![image](https://github.com/Parsifa1/nvim/assets/31800073/0e1dc351-3601-44e6-9c0b-7b9011333d73)


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
│   ├── keymap.lua
│   ├── option.lua
│   ├── packer.lua
│   ├── plugins
│   │   ├── dap
│   │   │   ├── dap.lua
│   │   │   ├── dap-ui.lua
│   │   │   ├── dap-virtual-text.lua
│   │   │   └── mason-dap.lua
│   │   ├── edit
│   │   │   ├── autopair.lua
│   │   │   ├── comment.lua
│   │   │   ├── conform.lua
│   │   │   ├── copilot.lua
│   │   │   ├── flash.lua
│   │   │   ├── flatten.lua
│   │   │   ├── nvim-surround.lua
│   │   │   ├── sleuth.lua
│   │   │   ├── todo-comments.lua
│   │   │   ├── treesitter-textobjects.lua
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── init.lua
│   │   ├── lang
│   │   │   ├── markdown-preview.lua
│   │   │   ├── markdown-typmath.lua
│   │   │   ├── markview.lua
│   │   │   ├── rustacean.lua
│   │   │   └── typst-preview.lua
│   │   ├── lsp
│   │   │   ├── cmp.lua
│   │   │   ├── lsp.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── mason.lua
│   │   │   └── treesitter.lua
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   ├── nightfox.lua
│   │   │   └── onedark.lua
│   │   ├── tools
│   │   │   ├── asynctasks.lua
│   │   │   ├── codesnap.lua
│   │   │   ├── compatitest.lua
│   │   │   ├── fzflua.lua
│   │   │   ├── suda.lua
│   │   │   ├── telescope.lua
│   │   │   ├── toggleterm.lua
│   │   │   ├── trouble.lua
│   │   │   ├── wakatime.lua
│   │   │   └── workspace.lua
│   │   ├── ui
│   │   │   ├── alpha.lua
│   │   │   ├── dressing.lua
│   │   │   ├── dropbar.lua
│   │   │   ├── edgy.lua
│   │   │   ├── fidget.lua
│   │   │   ├── incline.lua
│   │   │   ├── indent-blankline.lua
│   │   │   ├── lualine.lua
│   │   │   ├── mini-file.lua
│   │   │   ├── noice.lua
│   │   │   ├── nvim-colorizer.lua
│   │   │   ├── nvim-notify.lua
│   │   │   ├── nvim-ufo.lua
│   │   │   ├── oil.lua
│   │   │   ├── outline.lua
│   │   │   ├── rainbow-delimiters.lua
│   │   │   └── statuscol.lua
│   │   └── utils
│   │       ├── direnv.lua
│   │       ├── gp.lua
│   │       ├── image.lua
│   │       ├── leetcode.lua
│   │       ├── neorg.lua
│   │       ├── restore_view.lua
│   │       └── simple-usage.lua
│   ├── server.lua
│   ├── snippets
│   │   ├── cpp.lua
│   │   └── typst.lua
│   ├── user
│   │   └── autocmd.lua
│   └── utils
│       ├── autocmd.lua
│       ├── floaterm.lua
│       └── init.lua
├── README.md
├── stylua.toml
└── tasks.ini

15 directories, 85 files
```
