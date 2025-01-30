[{1 :L3MON4D3/LuaSnip
  :build ((fn []
            (when (= (vim.fn.has :win32) 1) (lua "return "))
            "make install_jsregexp"))
  :config (fn []
            ((. (require :luasnip) :config :setup) {:enable_autosnippets true})
            ((. (require :luasnip.loaders.from_lua) :lazy_load) {:paths (.. (vim.fn.stdpath :data)
                                                                            :/nfnl/lua/snippets)})
            ((. (require :luasnip.loaders.from_vscode) :lazy_load)))
  :dependencies [:rafamadriz/friendly-snippets
                 :nvim-treesitter/nvim-treesitter
                 :TwIStOy/luasnip-snippets]
  :event "User AfterLoad"
  :keys [{1 :<C-f>
          2 "<cmd>lua require('luasnip').expand()<CR>"
          :desc "snippets trigger"}]}
 {1 :TwIStOy/luasnip-snippets
  :dependencies [:L3MON4D3/LuaSnip]
  :opts {:disable_auto_expansion {:cpp [:i32 :i64]}}}]
