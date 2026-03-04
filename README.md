# my-neovim

My personal Noevim configuration, using Lazy.nvim as the package manager, strives to be highly customizable.

Full lua configuration, built using the latest neovim-nightly.

![example](https://raw.githubusercontent.com/Parsifa1/graph/master/nvim.png)

Startup Time:
![image](https://raw.githubusercontent.com/Parsifa1/graph/master/nvim-bench.png)

- LSP
- Tree-sitter
- Blink.cmp

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
│   │   │   ├── smartab.lua
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
│   │   │   ├── config.lua
│   │   │   ├── lazydev.lua
│   │   │   ├── luasnip.lua
│   │   │   ├── mason.lua
│   │   │   └── treesitter.lua
│   │   ├── theme
│   │   │   ├── catppuccin.lua
│   │   │   ├── everforest.lua
│   │   │   ├── gruvbox-md.lua
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
│   │   │   ├── nvim-ufo.lua
│   │   │   ├── nvzone.lua
│   │   │   ├── oil.lua
│   │   │   ├── outline.lua
│   │   │   ├── quickfix.lua
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
│   │   └── nvim-origami
│   │       └── lua
│   │           └── nvim-origami.lua
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

