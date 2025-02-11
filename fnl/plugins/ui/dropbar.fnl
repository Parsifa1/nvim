(local custom (require :custom))
(local custom-path {:get_symbols (fn [buff win cursor]
                                   (local symbols
                                          ((. (require :dropbar.sources) :path
                                              :get_symbols) buff win cursor))
                                   (vim.api.nvim_set_hl 0 :DropBarFileName
                                                        {:fg "#FCDCDD"
                                                         :italic true})
                                   (tset (. symbols (length symbols)) :name_hl
                                         :DropBarFileName)
                                   (when (. vim.bo buff :modified)
                                     (tset (. symbols (length symbols)) :name
                                           (.. (. symbols (length symbols)
                                                  :name)
                                               " [+]"))
                                     (tset (. symbols (length symbols))
                                           :name_hl :DiffAdded))
                                   symbols)})

{1 :Bekaboo/dropbar.nvim
 :event [:BufRead :BufNewFile]
 :opts {:bar {:sources (fn [buf _]
                         (local sources (require :dropbar.sources))
                         (local utils (require :dropbar.utils))
                         (when (= (. vim.bo buf :ft) :markdown)
                           [custom-path sources.markdown])
                         (when (= (. vim.bo buf :buftype) :terminal)
                           [sources.terminal])
                         [custom-path
                          (utils.source.fallback [sources.lsp
                                                  sources.treesitter])])}
        :icons {:kinds {:symbols custom.icons.kind_with_space}}}}
