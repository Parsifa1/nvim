(import-macros {: and!} :macros)
(let [auto vim.api.nvim_create_autocmd
      augruop vim.api.nvim_create_augroup
      execmds vim.api.nvim_exec_autocmds]
  ;; avoid comment when making new line
  (auto :FileType {:command "set formatoptions-=ro" :pattern "*"})
  ;; Wrap text in markdown, typst, and Avante files
  (auto :BufEnter {:callback #(let [ft [:markdown :typst :Avante]
                                    current-ft vim.bo.filetype]
                                (match (vim.tbl_contains ft current-ft)
                                  true (set vim.wo.wrap true)
                                  false (set vim.wo.wrap false)))
                   :pattern "*"})
  ;; Highlight yank
  (auto :TextYankPost
        {:callback #(vim.highlight.on_yank)
         :desc "Highlight when yanking (copying) text"
         :group (augruop :highlight-yank {:clear true})})
  ;; set User AfterLoad
  (auto :User {:callback #(let [trig #(execmds :User {:pattern :AfterLoad})]
                            (if (= vim.bo.filetype :snacks_dashboard)
                                (auto :BufRead {:callback trig :once true})
                                (trig)))
               :pattern :VeryLazy})
  ;; check if file is modified
  (auto [:FocusGained :TermClose :TermLeave]
        {:callback #(when (not= vim.o.buftype :nofile)
                      (vim.cmd :checktime))
         :group (augruop :checktime {:clear true})})
  ;; disable diagnostics in select mode
  (auto :ModeChanged {:callback #(vim.diagnostic.enable false)
                      :group (augruop :diag_in_select {:clear true})
                      :pattern "*:s"})
  (auto :ModeChanged {:callback #(vim.diagnostic.enable)
                      :group (augruop :diag_in_select {:clear true})
                      :pattern "[is]:n"})
  ;; set color scheme warpped for terminal
  (auto [:UIEnter :ColorScheme]
        {:callback #(let [normal (vim.api.nvim_get_hl 0 {:name :Normal})
                          str #(string.format "\027]11;#%06x\027\\" $1)]
                      (match normal.bg nil nil bg (io.write (str bg))))})
  (auto :UILeave {:callback #(io.write "\027]111\027\\")})
  ;;auto-foldview
  (auto [:BufWinLeave :BufWritePost :WinLeave]
        {:callback #(when (. vim.b $1.buf :view_activated)
                      (vim.cmd.mkview {:mods {:emsg_silent true}}))
         :group (augruop :auto_view {:clear true})})
  (auto :BufWinEnter
        {:callback #(when (not (. vim.b $1.buf :view_activated))
                      (let [get_option_value vim.api.nvim_get_option_value
                            filetype (get_option_value :filetype {:buf $1.buf})
                            buftype (get_option_value :buftype {:buf $1.buf})
                            ignore-filetypes [:gitcommit :gitrebase :hgcommit]]
                        (when (and! (= buftype "") filetype (= filetype "")
                                    (vim.tbl_contains ignore-filetypes filetype))
                          (tset (. vim.b $1.buf) :view_activated true)
                          (vim.cmd.loadview {:mods {:emsg_silent true}}))))
         :group (augruop :auto_view {:clear true})})
  (auto :SessionLoadPost
        {:callback #(vim.cmd.loadview {:mods {:emsg_silent true}})
         :group (augruop :auto_view {:clear true})}))
