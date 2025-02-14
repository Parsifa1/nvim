(local ft [:html
           :css
           :javascript
           :typescript
           :javascriptreact
           :typescriptreact
           :lua
           :fnl
           :yaml
           :fish])

{1 :NvChad/nvim-colorizer.lua
 :config (fn []
           ((. (require :colorizer) :setup) {:filetypes ft
                                             :user_default_options {:mode :virtualtext
                                                                    :virtualtext "󱓻 "
                                                                    :virtualtext_inline true}}))
 : ft}
