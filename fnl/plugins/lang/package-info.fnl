{1 :vuki656/package-info.nvim
 :commit :268f466
 :config (fn []
           ((. (require :package-info) :setup) {:autostart false
                                                :package_manager :pnpm})
           (let [autocmd vim.api.nvim_create_autocmd
                 de_fn vim.defer_fn]
             (autocmd :BufEnter
                      {:callback (fn []
                                   (de_fn (fn []
                                            (pcall (fn []
                                                     ((. (require :package-info)
                                                         :show)))))
                                          500))
                       :pattern :package.json})))
 :event ["BufRead package.json"]}
