(local autocmd vim.api.nvim_create_autocmd)
(fn config []
  (fn handler [virt-text lnum end-lnum width truncate]
    (let [new-virt-text {}
          suffix-fmt (: " %d " :format (- end-lnum lnum))
          suf-width (vim.fn.strdisplaywidth suffix-fmt)
          target-width (- width suf-width)]
      (fn process-chunks [chunks-left cur-width idx]
        (if (> idx (length chunks-left))
            (do
              (table.insert new-virt-text [suffix-fmt :MoreMsg])
              new-virt-text)
            (let [chunk (. chunks-left idx)
                  chunk-text (. chunk 1)
                  chunk-width (vim.fn.strdisplaywidth chunk-text)
                  remaining (- target-width cur-width)]
              (if (<= (+ cur-width chunk-width) target-width)
                  (do
                    (table.insert new-virt-text chunk)
                    (process-chunks chunks-left (+ cur-width chunk-width)
                                    (+ idx 1)))
                  (let [truncated-text (truncate chunk-text remaining)
                        truncated-width (vim.fn.strdisplaywidth truncated-text)
                        padding (- remaining truncated-width)
                        final-suffix (if (> padding 0)
                                         (.. suffix-fmt
                                             (string.rep " " padding))
                                         suffix-fmt)]
                    (table.insert new-virt-text [truncated-text (. chunk 2)])
                    (table.insert new-virt-text [final-suffix :MoreMsg])
                    new-virt-text)))))

      (process-chunks virt-text 0 1)))

  (vim.keymap.set :n :zn (. (require :ufo) :openAllFolds))
  (vim.keymap.set :n :zm (. (require :ufo) :closeAllFolds))
  (let [ufo (. (require :ufo) :setup)
        ft-map {:git "" :vim :indent :snacks_dashboard ""}]
    (ufo {:fold_virt_text_handler handler
          :provider_selector (fn [_ filetype _] (. ft-map filetype))
          :close_fold_kinds_for_ft {:c [:comment :region]
                                    :default [:imports :comment]}})))

{1 :kevinhwang91/nvim-ufo
 :dependencies :kevinhwang91/promise-async
 :event :BufReadPost
 : config
 :init #(let [augroup vim.api.nvim_create_augroup
              foldcolumn-for-file (augroup :foldcolumn_for_file {:clear true})]
          (autocmd :BufWinEnter
                   {:callback #(set vim.wo.foldcolumn
                                    (if (= vim.bo.buftype "") :1 :0))
                    :group foldcolumn-for-file})
          (autocmd :OptionSet
                   {:pattern :buftype
                    :callback #(set vim.wo.foldcolumn
                                    (if (= vim.bo.buftype "") :1 :0))
                    :group foldcolumn-for-file})
          (autocmd :FileType {:callback #(set vim.opt.foldenable false)
                              :pattern [:leetcode.nvim
                                        :lazy
                                        :snacks_dashboard
                                        :help]})
          (set vim.o.foldlevel 99)
          (set vim.o.foldlevelstart 99)
          (set vim.o.foldenable true))}
