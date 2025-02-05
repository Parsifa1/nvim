(local custom (require :custom))
{1 :stevearc/oil.nvim
 :dependencies [:nvim-tree/nvim-web-devicons]
 :init (fn []
         (local autocmd vim.api.nvim_create_autocmd)
         (when (= (vim.fn.argc) 1)
           ((. (require :lazy) :load) {:plugins [:oil.nvim]}))
         (when (not (. (require :lazy.core.config) :plugins :oil.nvim "_"
                       :loaded))
           (autocmd :BufNew {:callback (fn []
                                         (when (= (vim.fn.isdirectory (vim.fn.expand :<afile>))
                                                  1)
                                           ((. (require :lazy) :load) {:plugins [:oil.nvim]})
                                           true))})))
 :keys [{1 "-"
         2 (fn []
             (when (not= vim.bo.filetype :minifiles)
               ((. (require :oil) :open))))
         :desc "Open parent directory"}]
 :opts {:cleanup_delay_ms false
        :columns [:icon]
        :default_file_explorer true
        :float {:border custom.border}
        :keymaps {:- :actions.close
                  :. :actions.toggle_hidden
                  :<C-h> false
                  :<C-l> false
                  :<C-s> false
                  :<CR> :actions.select
                  :H :actions.parent
                  :L :actions.select
                  :_ :actions.open_cwd
                  "`" :actions.cd
                  :zs :actions.select_split
                  :zv :actions.select_vsplit}
        :preview {:border custom.border}
        :progress {:border custom.border}
        :skip_confirm_for_simple_edits true
        :view_options {:show_hidden true}}}
