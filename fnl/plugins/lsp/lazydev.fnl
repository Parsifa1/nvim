{1 :folke/lazydev.nvim
 :dependencies [:Bilal2453/luvit-meta]
 :event :LspAttach
 :ft :lua
 :opts {:library [:../utils
                  {:path :luvit-meta/library :words ["vim%.uv" "vim%.loop"]}
                  {:path :lazy.nvim :words [:LazyPluginSpec]}]}}
