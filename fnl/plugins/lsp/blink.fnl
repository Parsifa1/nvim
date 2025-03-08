(import-macros {: init : or!} :macros)

(fn super-tab [direction]
  (fn callback [cmp]
    (let [ls (require :luasnip)
          get-current-buf vim.api.nvim_get_current_buf
          node (. ls.session.current_nodes (get-current-buf))
          return? (or! (not ls.session) (not node) ls.session.jump_active)]
      (if return?
          false
          (let [[cur-row cur-col] (vim.api.nvim_win_get_cursor 0)
                ([start-row start-col] [end-row end-col]) (node:get_buf_position)]
            (or! (< cur-col start-col) (> cur-col end-col)
                 (< cur-row (+ start-row 1)) (> cur-row (+ end-row 1))))
          (do
            (ls.unlink_current) false)
          (do
            (if (= direction :backward) (cmp.snippet_backward)
                (= direction :forward) (cmp.snippet_forward))))))

  (let [select #(if (= direction :backward) :select_prev :select_next)]
    [callback (select) :fallback]))

(local custom (require :custom))
(local opts {})

;; opts
(let [cfg opts]
  (init cfg :fuzzy :prebuilt_binaries {:ignore_version_mismatch true})
  (init cfg :appearance {:kind_icons custom.icons.kind
                         :use_nvim_cmp_as_default true})
  (let [signature (init cfg :signature {})]
    (init signature :enabled true)
    (init signature :window :border :single))
  (let [completion (init cfg :completion {})]
    (let [accept (init completion :accept {})]
      (let [auto_brackets (init accept :auto_brackets {})
            blocked [:typescriptreact :javascript :vue :rust :fennel]]
        (init auto_brackets {:enabled true :kind_resolution {:enabled true}})
        (init auto_brackets :kind_resolution :blocked_filetypes blocked)))
    (let [document (init completion :documentation {})]
      (init document :auto_show true)
      (init document {:window {:border :single :scrollbar false}}))
    (let [selection (init completion :list :selection {})]
      (init selection :auto_insert #(= $1.mode :cmdline))
      (init selection :preselect #(not= $1.mode :cmdline)))
    (let [menu (init completion :menu {})]
      (init menu {:border :single :scrollbar false})
      (init menu :winhighlight
            "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None")
      (init menu :draw
            {:treesitter [:lsp]
             :columns [[:kind_icon] {1 :label :gap 1} [:provider]]})
      (let [label (init menu :draw :components :label {})]
        (init label :highlight
              #((. (require :colorful-menu) :blink_components_highlight) $1))
        (init label :text
              #((. (require :colorful-menu) :blink_components_text) $1))
        (init label :width :max #(if (= $1.mode :cmdline) 22 60)))
      (let [provider (init menu :draw :components :provider {})]
        (init provider {:highlight :Fg
                        :text #(let [sub (: ($1.item.source_name:sub 1 3)
                                            :upper)]
                                 (.. "[" sub "]"))})))
    (init completion :trigger :show_on_x_blocked_trigger_characters
          ["'" "\"" "(" "{"]))
  (let [sources (init cfg :sources {})]
    (init sources :default
          #(let [(success node) (pcall vim.treesitter.get_node)]
             (if (= vim.bo.filetype :lua) [:lsp :path :lazydev]
                 (and success node
                      (vim.tbl_contains [:comment :line_comment :block_comment]
                                        (node:type))) [:buffer]
                 [:lsp :path :snippets :buffer])))
    (let [providers (init sources :providers {})]
      (init providers :lazydev
            {:name :Development :module :lazydev.integrations.blink})
      (init providers :conjure
            {:name :conjure :module :blink.compat.source :score_offset -3})))
  (let [keymap (init cfg :keymap {})]
    (tset keymap :<C-CR> [:fallback])
    (tset keymap :<C-d> [:scroll_documentation_down :fallback])
    (tset keymap :<C-j> [:select_next :fallback])
    (tset keymap :<C-k> [:select_prev :fallback])
    (tset keymap :<C-u> [:scroll_documentation_up :fallback])
    (tset keymap :<C-w> [:show :hide :show_documentation :hide_documentation])
    (tset keymap :<CR> [:accept :fallback])
    (tset keymap :<Down> [:select_next :fallback])
    (tset keymap :<S-Tab> (super-tab :backward))
    (tset keymap :<Tab> (super-tab :forward))
    (tset keymap :<Up> [:select_prev :fallback]))
  (let [snippets (init cfg :snippets {})]
    (init snippets :active
          (fn [filter]
            (when (and filter filter.direction)
              (. (require :luasnip) :locally_jumpable))
            ((. (require :luasnip) :in_snippet))))
    (init snippets :expand #((. (require :luasnip) :lsp_expand) $1))
    (init snippets :jump #((. (require :luasnip) :jump) $1)))
  (let [cmdline (init cfg :cmdline {})]
    (init cmdline :completion :menu :draw :columns [[:kind_icon] [:label]])
    (init cmdline :completion :menu :auto_show #(= ":" (vim.fn.getcmdtype)))
    (init cmdline :completion :list :selection :preselect false)
    (let [keymap (init cmdline :keymap {})
          feedkeys vim.api.nvim_feedkeys]
      (tset keymap :<C-f> [:accept :fallback])
      (tset keymap :<C-j> [:select_next :fallback])
      (tset keymap :<C-k> [:select_prev :fallback])
      (tset keymap :<CR> [#($1.accept {:callback #(feedkeys "\n" :n true)})
                          :fallback]))))

{1 :Saghen/blink.cmp
 :version "*"
 :dependencies [:PaterJason/cmp-conjure
                :zbdmw/colorful-menu.nvim
                {1 :saghen/blink.compat}]
 :event [:CursorHold :CursorHoldI :CmdlineEnter "User AfterLoad"]
 :opts_extend [:sources.completion.enabled_providers]
 : opts}
