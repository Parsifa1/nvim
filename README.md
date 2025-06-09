# my-neovim

My personal Noevim configuration, using Lazy.nvim as the package manager, strives to be highly customizable.

Full lua configuration, built using the latest neovim-nightly.

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/neovim.png)

Startup Time:
![image](https://github.com/Parsifa1/nvim/assets/31800073/0e1dc351-3601-44e6-9c0b-7b9011333d73)

- LSP
- Tree-sitter
- CMP

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
│   │   │   ├── dap-ui.lua
│   │   │   ├── dap-view.lua
│   │   │   ├── dap-virtual-text.lua
│   │   │   ├── dap.lua
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
│   │   │   ├── smart-tab.lua
│   │   │   ├── todo-comments.lua
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── diffview.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── init.lua
│   │   ├── lang
│   │   │   ├── markdown.lua
│   │   │   ├── moonbit.lua
│   │   │   ├── package-info.lua
│   │   │   ├── rust.lua
│   │   │   ├── typescript.lua
│   │   │   └── typst-preview.lua
│   │   ├── lsp
│   │   │   ├── blink.lua
│   │   │   ├── lazydev.lua
│   │   │   ├── lspconfig.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── mason.lua
│   │   │   └── treesitter.lua
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   ├── gruvbox-md.lua
│   │   │   ├── gruvbox.lua
│   │   │   └── nightfox.lua
│   │   ├── tools
│   │   │   ├── asynctasks.lua
│   │   │   ├── codecompanion.lua
│   │   │   ├── compatitest.lua
│   │   │   ├── fzflua.lua
│   │   │   ├── mcphub.lua
│   │   │   ├── mundo.lua
│   │   │   ├── nvim-silicon.lua
│   │   │   ├── origami.lua
│   │   │   ├── session_manager.lua
│   │   │   ├── snacks.lua
│   │   │   ├── suda.lua
│   │   │   ├── toggleterm.lua
│   │   │   ├── trailblazer.lua
│   │   │   ├── trouble.lua
│   │   │   └── wakatime.lua
│   │   ├── ui
│   │   │   ├── cockline.lua
│   │   │   ├── colorful-menu.lua
│   │   │   ├── dressing.lua
│   │   │   ├── dropbar.lua
│   │   │   ├── edgy.lua
│   │   │   ├── fidget.lua
│   │   │   ├── indent-blankline.lua
│   │   │   ├── lualine.lua
│   │   │   ├── mini.lua
│   │   │   ├── noice.lua
│   │   │   ├── nvim-colorizer.lua
│   │   │   ├── nvim-ufo.lua
│   │   │   ├── nvzone.lua
│   │   │   ├── oil.lua
│   │   │   ├── outline.lua
│   │   │   ├── quickfix.lua
│   │   │   ├── rainbow-delimiters.lua
│   │   │   ├── statuscol.lua
│   │   │   └── whitespace.lua
│   │   └── utils
│   │       ├── direnv.lua
│   │       ├── leetcode.lua
│   │       └── multicursor.lua
│   ├── snippets
│   │   ├── cpp.lua
│   │   └── typst.lua
│   ├── users
│   │   ├── llm-spinner
│   │   │   └── lua
│   │   │       └── llm-spinner.lua
│   │   └── smart-tab
│   │       └── lua
│   │           └── smart-tab.lua
│   └── utils
│       ├── autocmd.lua
│       ├── floaterm.lua
│       ├── gitutils.lua
│       ├── highlight.lua
│       └── lspconfig.lua
├── queries
│   ├── html
│   │   └── injections.scm
│   └── markdown
│       └── injections.scm
├── README.md
├── stylua.toml
└── tasks.ini
```
