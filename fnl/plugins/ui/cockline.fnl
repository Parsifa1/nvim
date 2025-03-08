(fn config []
  (local get-hex (. (require :cokeline.hlgroups) :get_hl_attr))
  (local errors-fg (get-hex :DiagnosticError :fg))
  (local warnings-fg (get-hex :DiagnosticWarn :fg))
  (local components
         {:close {:on_click (fn [_ _ _ _ buffer] (buffer:delete))
                  :text #(if (and (= $1.diagnostics.errors 0)
                                  (= $1.diagnostics.warnings 0))
                             (if $1.is_modified "● " " ")
                             "")}
          :diagnostics {:fg #(if (not= $1.diagnostics.errors 0) errors-fg
                                 (not= $1.diagnostics.warnings 0) warnings-fg
                                 nil)
                        :text #(if (not= $1.diagnostics.errors 0) " "
                                   (not= $1.diagnostics.warnings 0) " "
                                   "")
                        :truncation {:priority 1}}
          :filename {:text #(.. $1.filename " ")
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
                                                :fg #(if $1.is_focused
                                                         (get-hex :TabLineFocus
                                                                  :fg)
                                                         (get-hex :Comment :fg))}
                                   :fill_hl :TabLineNone}))

{1 :willothy/nvim-cokeline
 : config
 :dependencies [:nvim-lua/plenary.nvim :nvim-tree/nvim-web-devicons]
 :event [:BufRead :BufNewFile]
 :keys [{1 "[b" 2 "<Plug>(cokeline-focus-prev)" :desc "previous buffer"}
        {1 "]b" 2 "<Plug>(cokeline-focus-next)" :desc "next buffer"}]}
