(let [auto vim.api.nvim_create_autocmd]
  (auto :FileType {:command "set formatoptions-=ro" :pattern "*"})
  (auto :BufEnter {:callback (fn []
                               (let [ft [:markdown :typst :Avante]
                                     current-ft vim.bo.filetype]
                                 (match (vim.tbl_contains ft current-ft)
                                   true (set vim.wo.wrap true)
                                   false (set vim.wo.wrap false))))
                   :pattern "*"})
  (auto :TextYankPost
        {:callback (fn [] (vim.highlight.on_yank))
         :desc "Highlight when yanking (copying) text"
         :group (vim.api.nvim_create_augroup :highlight-yank {:clear true})})
  (auto :User {:callback (fn []
                           (fn _trigger []
                             (vim.api.nvim_exec_autocmds :User
                                                         {:pattern :AfterLoad}))

                           (if (= vim.bo.filetype :snacks_dashboard)
                               (auto :BufRead {:callback _trigger :once true})
                               (_trigger)))
               :pattern :VeryLazy})
  (auto [:FocusGained :TermClose :TermLeave]
        {:callback (fn []
                     (when (not= vim.o.buftype :nofile)
                       (vim.cmd :checktime)))
         :group (vim.api.nvim_create_augroup :checktime {:clear true})})
  (auto :ModeChanged {:callback (fn [] (vim.diagnostic.enable false))
                      :group (vim.api.nvim_create_augroup :diag_in_select
                                                          {:clear true})
                      :pattern "*:s"})
  (auto :ModeChanged {:callback (fn [] (vim.diagnostic.enable))
                      :group (vim.api.nvim_create_augroup :diag_in_select
                                                          {:clear false})
                      :pattern "[is]:n"})
  (auto [:UIEnter :ColorScheme]
        {:callback (fn []
                     (let [normal (vim.api.nvim_get_hl 0 {:name :Normal})]
                       (match normal.bg
                         nil nil
                         bg (io.write (string.format "\027]11;#%06x\027\\" bg)))))})
  (auto :UILeave {:callback (fn [] (io.write "\027]111\027\\"))}))
