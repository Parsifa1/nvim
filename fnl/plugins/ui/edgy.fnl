{1 :folke/edgy.nvim
 :enabled true
 :event [:CursorHold :CursorHoldI "User AfterLoad"]
 :opts {:animate {:enabled false}
        :bottom [:Trouble
                 {:ft :qf :title :QuickFix}
                 {:filter (fn [buf] (= (. vim.bo buf :buftype) :help))
                  :ft :help
                  :size {:height 20}}
                 {:filter (fn [_ win]
                            (= (. (vim.api.nvim_win_get_config win) :relative)
                               ""))
                  :ft :noice
                  :size {:height 0.4}}]
        :exit_when_last true
        :left [{:ft :Mundo :size {:width 0.25}}
               {:ft :MundoDiff :size {:width 0.25}}]
        :right [{:ft :Outline :open :Outline :pinned true :size {:width 0.3}}]}}
