(let [auto vim.api.nvim_create_autocmd
      augruop vim.api.nvim_create_augroup
      execmds vim.api.nvim_exec_autocmds]
  (auto :FileType {:command "set formatoptions-=ro" :pattern "*"})
  (auto :BufEnter {:callback #(let [ft [:markdown :typst :Avante]
                                    current-ft vim.bo.filetype]
                                (match (vim.tbl_contains ft current-ft)
                                  true (set vim.wo.wrap true)
                                  false (set vim.wo.wrap false)))
                   :pattern :*})
  (auto :TextYankPost
        {:callback #(vim.highlight.on_yank)
         :desc "Highlight when yanking (copying) text"
         :group (augruop :highlight-yank {:clear true})})
  (auto :User {:callback #(let [trig #(execmds :User {:pattern :AfterLoad})]
                            (if (= vim.bo.filetype :snacks_dashboard)
                                (auto :BufRead {:callback trig :once true})
                                (trig)))
               :pattern :VeryLazy})
  (auto [:FocusGained :TermClose :TermLeave]
        {:callback #(when (not= vim.o.buftype :nofile)
                      (vim.cmd :checktime))
         :group (augruop :checktime {:clear true})})
  (auto :ModeChanged {:callback #(vim.diagnostic.enable false)
                      :group (augruop :diag_in_select {:clear true})
                      :pattern "*:s"})
  (auto :ModeChanged {:callback #(vim.diagnostic.enable)
                      :group (augruop :diag_in_select {:clear false})
                      :pattern "[is]:n"})
  (auto [:UIEnter :ColorScheme]
        {:callback #(let [normal (vim.api.nvim_get_hl 0 {:name :Normal})
                          str #(string.format "\027]11;#%06x\027\\" $1)]
                      (match normal.bg nil nil bg (io.write (str bg))))})
  (auto :UILeave {:callback #(io.write "\027]111\027\\")}))
