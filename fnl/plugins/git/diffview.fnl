{1 :sindrets/diffview.nvim
 :cmd [:DiffviewOpen :DiffviewFileHistory]
 :keys [{1 :<leader>gdo 2 :<Cmd>DiffviewOpen<CR> :desc :Open}
        {1 :<leader>gdc 2 :<Cmd>DiffviewClose<CR> :desc :Close}
        {1 :<leader>gdh 2 :<Cmd>DiffviewFileHistory<CR> :desc "Open History"}
        {1 :<leader>gdf
         2 "<Cmd>DiffviewFileHistory %<CR>"
         :desc "Current History"}]
 :opts (fn []
         (local actions (require :diffview.actions))
         {:enhanced_diff_hl true
          :file_panel {:win_config {:width (let [width (math.floor (* vim.go.columns
                                                                      0.2))]
                                             (match width
                                               (where w (> w 25)) w
                                               _ 25))}}
          :hooks {:diff_buf_win_enter (fn [_ winid]
                                        (tset (. vim.wo winid) :wrap false))}
          :keymaps {:file_history_panel [[:n
                                          :q
                                          actions.close
                                          {:desc "Close diffview"}]
                                         [:n
                                          :<Esc>
                                          actions.close
                                          {:desc "Close diffview"}]]
                    :file_panel [[:n :q actions.close {:desc "Close diffview"}]
                                 [:n
                                  :<Esc>
                                  actions.close
                                  {:desc "Close diffview"}]]
                    :view [[:n :q actions.close {:desc "Close diffview"}]
                           [:n :<Esc> actions.close {:desc "Close diffview"}]]}
          :show_help_hints false})}
