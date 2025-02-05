{1 :willothy/nvim-cokeline
 :config (fn []
           (local get-hex (. (require :cokeline.hlgroups) :get_hl_attr))
           (local errors-fg (get-hex :DiagnosticError :fg))
           (local warnings-fg (get-hex :DiagnosticWarn :fg))
           (local components
                  {:close {:on_click (fn [_ _ _ _ buffer] (buffer:delete))
                           :text (fn [buffer]
                                   (if (and (= buffer.diagnostics.errors 0)
                                            (= buffer.diagnostics.warnings 0))
                                       (if buffer.is_modified "● " " ")
                                       ""))}
                   :diagnostics {:fg (fn [buffer]
                                       (or (or (and (not= buffer.diagnostics.errors
                                                          0)
                                                    errors-fg)
                                               (and (not= buffer.diagnostics.warnings
                                                          0)
                                                    warnings-fg))
                                           nil))
                                 :text (fn [buffer]
                                         (if (not= buffer.diagnostics.errors 0)
                                             " "
                                             (not= buffer.diagnostics.warnings
                                                   0)
                                             " "
                                             ""))
                                 :truncation {:priority 1}}
                   :filename {:text (fn [buffer] (.. buffer.filename " "))
                              :underline (fn [buffer]
                                           (and buffer.is_hovered
                                                (not buffer.is_focused)))}
                   :icon {:fg (fn [buffer] buffer.devicon.color)
                          :text (fn [buffer] (.. " " buffer.devicon.icon))}
                   :space {:text " "}
                   :unique_prefix {:fg (get-hex :Comment :fg)
                                   :italic true
                                   :text (fn [buffer] buffer.unique_prefix)}})
           ((. (require :cokeline) :setup) {:components [components.icon
                                                         components.unique_prefix
                                                         components.filename
                                                         components.diagnostics
                                                         components.close
                                                         components.space]
                                            :default_hl {:bg :NONE
                                                         :fg (fn [buffer]
                                                               (or (and buffer.is_focused
                                                                        (get-hex :TabLineFocus
                                                                                 :fg))
                                                                   (get-hex :Comment
                                                                            :fg)))}
                                            :fill_hl :TabLineNone}))
 :dependencies [:nvim-lua/plenary.nvim :nvim-tree/nvim-web-devicons]
 :event [:BufRead :BufNewFile]
 :keys [{1 "[b" 2 "<Plug>(cokeline-focus-prev)" :desc "previous buffer"}
        {1 "]b" 2 "<Plug>(cokeline-focus-next)" :desc "next buffer"}]}
