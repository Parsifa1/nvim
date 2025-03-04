(local ft [:html
           :css
           :javascript
           :typescript
           :javascriptreact
           :typescriptreact
           :lua
           :yaml
           :fennel
           :fish])

{1 :NvChad/nvim-colorizer.lua
 : ft
 :config #(let [colorizer (. (require :colorizer) :setup)]
            (colorizer {:filetypes ft
                        :user_default_options {:mode :virtualtext
                                               :virtualtext "󱓻 "
                                               :virtualtext_inline true}}))}
