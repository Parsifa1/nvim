(local session-config {:hls {:title :TelescopePromptTitle}
                       :prompt false
                       :winopts {:col 0.5
                                 :height 0.35
                                 :row 0.5
                                 :title " Sessions "
                                 :title_pos :center
                                 :width 0.47}})

{1 :stevearc/dressing.nvim
 :opts {:select {:backend [:fzf_lua :telescope]
                 :fzf_lua {:winopts {:col 0.5
                                     :height 0.25
                                     :row 0.5
                                     :width 0.37}}
                 :get_config (fn [opts]
                               (when (= opts.prompt "Load Session")
                                 (local themes (require :telescope.themes))
                                 (local backend
                                        (or (and (= (. (vim.uv.os_uname)
                                                       :sysname)
                                                    :Windows_NT)
                                                 :telescope)
                                            :fzf_lua))
                                 {:backend [backend]
                                  :fzf_lua session-config
                                  :telescope (themes.get_dropdown {})})
                               (when (= opts.kind :codeaction) {}))}}}
