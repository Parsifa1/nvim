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
│   ├── config
│   │   ├── custom.lua
│   │   ├── keymap.lua
│   │   ├── option.lua
│   │   └── packer.lua
│   ├── plugins
│   │   ├── dap
│   │   │   ├── dap.lua
│   │   │   ├── dap-view.lua
│   │   │   ├── dap-virtual-text.lua
│   │   │   └── mason-dap.lua
│   │   ├── edit
│   │   │   ├── autopair.lua
│   │   │   ├── comment.lua
│   │   │   ├── conform.lua
│   │   │   ├── flash.lua
│   │   │   ├── flatten.lua
│   │   │   ├── nvim-surround.lua
│   │   │   ├── sleuth.lua
│   │   │   ├── smartab.lua
│   │   │   ├── todo-comments.lua
│   │   │   └── which-key.lua
│   │   ├── git
│   │   │   ├── diffview.lua
│   │   │   ├── git-conflict.lua
│   │   │   ├── gitlinker.lua
│   │   │   ├── gitsigns.lua
│   │   │   └── neogit.lua
│   │   ├── init.lua
│   │   ├── lang
│   │   │   ├── lisp.lua
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
│   │   │   ├── evergarden.lua
│   │   │   ├── gruvbox-md.lua
│   │   │   └── nightfox.lua
│   │   ├── tools
│   │   │   ├── asynctasks.lua
│   │   │   ├── direnv.lua
│   │   │   ├── fzflua.lua
│   │   │   ├── grug-far.lua
│   │   │   ├── marks.lua
│   │   │   ├── multicursor.lua
│   │   │   ├── mundo.lua
│   │   │   ├── origami.lua
│   │   │   ├── session_manager.lua
│   │   │   ├── sidekick.lua
│   │   │   ├── snacks.lua
│   │   │   ├── suda.lua
│   │   │   ├── toggleterm.lua
│   │   │   ├── trouble.lua
│   │   │   └── wakatime.lua
│   │   ├── ui
│   │   │   ├── cockline.lua
│   │   │   ├── colorful-menu.lua
│   │   │   ├── dressing.lua
│   │   │   ├── dropbar.lua
│   │   │   ├── edgy.lua
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
│   │       ├── compatitest.lua
│   │       ├── leetcode.lua
│   │       └── nvim-silicon.lua
│   ├── snippets
│   │   ├── cpp.lua
│   │   ├── markdown.lua
│   │   ├── python.lua
│   │   └── typst.lua
│   ├── users
│   │   ├── code-runner
│   │   │   └── lua
│   │   │       └── code-runner.lua
│   │   └── nvim-origami
│   │       └── lua
│   │           ├── hlsearch.lua
│   │           └── nvim-origami.lua
│   └── utils
│       ├── autocmd.lua
│       ├── function.lua
│       ├── highlight.lua
│       ├── lsp
│       │   ├── astro.lua
│       │   ├── clangd.lua
│       │   ├── cssls.lua
│       │   ├── hls.lua
│       │   ├── lua_ls.lua
│       │   ├── mdx_analyzer.lua
│       │   ├── tailwindcss.lua
│       │   └── vtsls.lua
│       └── lspstart.lua
├── queries
│   ├── html
│   │   └── injections.scm
│   ├── markdown
│   │   └── injections.scm
│   └── rust
│       └── injections.scm
├── README.md
├── stylua.toml
├── tasks.ini
└── tests
```

