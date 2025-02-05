(local config
       (fn []
         (fn handler [virt-text lnum end-lnum width truncate]
           (local new-virt-text {})
           (var suffix (: " %d " :format (- end-lnum lnum)))
           (local suf-width (vim.fn.strdisplaywidth suffix))
           (local target-width (- width suf-width))
           (var cur-width 0)
           (each [_ chunk (ipairs virt-text)]
             (var chunk-text (. chunk 1))
             (var chunk-width (vim.fn.strdisplaywidth chunk-text))
             (if (> target-width (+ cur-width chunk-width))
                 (table.insert new-virt-text chunk)
                 (do
                   (set chunk-text
                        (truncate chunk-text (- target-width cur-width)))
                   (local hl-group (. chunk 2))
                   (table.insert new-virt-text [chunk-text hl-group])
                   (set chunk-width (vim.fn.strdisplaywidth chunk-text))
                   (when (< (+ cur-width chunk-width) target-width)
                     (set suffix
                          (.. suffix
                              (: " " :rep
                                 (- (- target-width cur-width) chunk-width)))))
                   (lua :break)))
             (set cur-width (+ cur-width chunk-width)))
           (table.insert new-virt-text [suffix :MoreMsg])
           new-virt-text)

         (vim.api.nvim_create_autocmd :FileType
                                      {:callback (fn []
                                                   ((. (require :ufo) :detach))
                                                   (set vim.opt_local.foldenable
                                                        false)
                                                   (set vim.opt_local.foldcolumn
                                                        :0))
                                       :pattern [:leetcode.nvim
                                                 :lazy
                                                 :snacks_dashboard]})
         (vim.keymap.set :n :zn (. (require :ufo) :openAllFolds))
         (vim.keymap.set :n :zm (. (require :ufo) :closeAllFolds))
         ((. (require :ufo) :setup) {:close_fold_kinds_for_ft {:c [:comment
                                                                   :region]
                                                               :default [:imports
                                                                         :comment]
                                                               :json [:array]}
                                     :fold_virt_text_handler handler})))

{1 :kevinhwang91/nvim-ufo
 :dependencies :kevinhwang91/promise-async
 :event "User AfterLoad"
 : config
 :init (fn []
         (local autocmd vim.api.nvim_create_autocmd)
         (local augroup vim.api.nvim_create_augroup)
         (local set-foldcolumn-for-file
                (augroup :set_foldcolumn_for_file {:clear true}))
         (autocmd :BufWinEnter
                  {:callback (fn []
                               (set vim.wo.foldcolumn
                                    (or (and (= vim.bo.buftype "") :1) :0)))
                   :group set-foldcolumn-for-file})
         (autocmd :OptionSet {:callback (fn []
                                          (set vim.wo.foldcolumn
                                               (or (and (= vim.bo.buftype "")
                                                        :1)
                                                   :0)))
                              :group set-foldcolumn-for-file
                              :pattern :buftype})
         (set vim.o.foldlevel 99)
         (set vim.o.foldlevelstart 99)
         (set vim.o.foldenable true))}
