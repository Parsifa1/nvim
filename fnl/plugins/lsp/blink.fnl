(import-macros {: init} :macros)

(macro kset [keymap ky actions]
  `(tset ,keymap ,ky ,actions))

(fn super-tab [direction]
  (let [ret [(fn [cmp]
               (let [ls (require :luasnip)
                     current-node (. ls.session.current_nodes
                                     (vim.api.nvim_get_current_buf))]
                 (when (or (or (not ls.session) (not current-node))
                           ls.session.jump_active)
                   (lua "return false"))
                 (local (current-start current-end)
                        (current-node:get_buf_position))
                 (tset current-start 1 (+ (. current-start 1) 1))
                 (tset current-end 1 (+ (. current-end 1) 1))
                 (local cursor (vim.api.nvim_win_get_cursor 0))
                 (when (or (or (or (< (. cursor 1) (. current-start 1))
                                   (> (. cursor 1) (. current-end 1)))
                               (< (. cursor 2) (. current-start 2)))
                           (> (. cursor 2) (. current-end 2)))
                   (ls.unlink_current)
                   (lua "return false"))
                 (cmp.hide)
                 (if (= direction :backward) (cmp.snippet_backward)
                     (= direction :forward) (cmp.snippet_forward))))
             :select_next
             :fallback]]
    (when (= direction :backward) (tset ret 2 :select_prev))
    ret))

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
      (let [auto_brackets (init accept :auto_brackets {})]
        (init auto_brackets {:enabled true :kind_resolution {:enabled true}})
        (init auto_brackets :kind_resolution :blocked_filetypes
              [:typescriptreact :javascriptreact :vue :rust :fennel])))
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
        (init label :width :max #(or (and (= $1.mode :cmdline) 22) 60)))
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
                 [:lsp :path :snippets :buffer :conjure])))
    (let [providers (init sources :providers {})]
      (init providers :lazydev
            {:name :Development :module :lazydev.integrations.blink})
      (init providers :conjure
            {:name :conjure :module :blink.compat.source :score_offset -3})))
  (let [keymap (init cfg :keymap {})]
    (kset keymap :<C-CR> [:fallback])
    (kset keymap :<C-d> [:scroll_documentation_down :fallback])
    (kset keymap :<C-j> [:select_next :fallback])
    (kset keymap :<C-k> [:select_prev :fallback])
    (kset keymap :<C-u> [:scroll_documentation_up :fallback])
    (kset keymap :<C-w> [:show :hide :show_documentation :hide_documentation])
    (kset keymap :<CR> [:accept :fallback])
    (kset keymap :<Down> [:select_next :fallback])
    (kset keymap :<S-Tab> (super-tab :backward))
    (kset keymap :<Tab> (super-tab :forward))
    (kset keymap :<Up> [:select_prev :fallback]))
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
    (let [keymap (init cmdline :keymap {})
          feedkeys vim.api.nvim_feedkeys]
      (kset keymap :<C-j> [:select_next :fallback])
      (kset keymap :<C-k> [:select_prev :fallback])
      (kset keymap :<S-Tab> [:select_prev :fallback])
      (kset keymap :<Tab> [:select_next :fallback])
      (kset keymap :<CR> [#($1.accept {:callback #(feedkeys "\n" :n true)})
                          :fallback])))
  (let [term (init cfg :term {})]
    (init term :enabled false)))

{1 :Saghen/blink.cmp
 :version "*"
 :dependencies [:PaterJason/cmp-conjure
                :zbdmw/colorful-menu.nvim
                {1 :saghen/blink.compat}]
 :event [:CursorHold :CursorHoldI :CmdlineEnter "User AfterLoad"]
 :opts_extend [:sources.completion.enabled_providers]
 : opts}
