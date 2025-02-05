{1 :EdenEast/nightfox.nvim
 :config (fn []
           ((let [nightfox (. (require :nightfox) :setup)]
              (nightfox {:options {:modules {:cmp {:enable true}}
                                   :styles {:comments :italic
                                            :keywords :bold
                                            :types "italic,bold"}}}))))
 ; :transparent (not vim.g.neovide)}}))))
 :priority 100}
