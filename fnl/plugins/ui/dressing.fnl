(local fzf_lua {:hls {:title :TelescopePromptTitle}
                :prompt false
                :winopts {:col 0.5
                          :row 0.5
                          :width 0.45
                          :height 0.35
                          :title " Sessions "
                          :title_pos :center}})

(fn get_config [opts]
  (if (= opts.prompt "Load Session")
      (let [backend (if (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
                        :snacks_picker
                        :fzf_lua)]
        {:backend [backend] : fzf_lua})
      (if (= opts.kind :codeaction)
          {}
          nil)))

{1 :stevearc/dressing.nvim
 :opts {:select {:backend [:fzf_lua :snacks_picker]
                 : get_config
                 :fzf_lua {:winopts {:col 0.5
                                     :height 0.25
                                     :row 0.5
                                     :width 0.37}}}}}
