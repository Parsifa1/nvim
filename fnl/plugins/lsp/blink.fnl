(local custom (require :custom))
(local opts {})
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

;; opts
(let [cfg opts]
  (let [appear (init cfg :appearance {})]
    (init appear :kind_icons custom.icons.kind)
    (init appear :use_nvim_cmp_as_default true))
  (let [signature (init cfg :signature {})]
    (init signature :enabled true)
    (init signature :window :border :single))
  (let [completion (init cfg :completion {})]
    (let [auto_brackets (init completion :accept :auto_brackets {})]
      (init auto_brackets :enabled true)
      (init auto_brackets :kind_resolution :enabled true)
      (init auto_brackets :kind_resolution :blocked_filetypes
            [:typescriptreact :javascriptreact :vue :rust :fennel]))
    (let [document (init completion :documentation {})]
      (init document :auto_show true)
      (init document :window :border :single)
      (init document :window :scrollbar false))
    (let [selection (init completion :list :selection {})]
      (init selection :auto_insert
            (fn [ctx]
              (= ctx.mode :cmdline)))
      (init selection :preselect
            (fn [ctx]
              (not= ctx.mode :cmdline))))
    (let [menu (init completion :menu {})]
      (init menu :border :single)
      (init menu :scrollbar false)
      (init menu :winhighlight
            "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None")
      (let [draw (init menu :draw {})]
        (init draw :treesitter [:lsp])
        (init draw :columns
              (fn [ctx]
                (or (and (= ctx.mode :cmdline) [[:kind_icon] [:label]])
                    [[:kind_icon] {1 :label :gap 1} [:provider]])))
        (let [label (init menu :draw :components :label {})]
          (init label :highlight
                (fn [ctx]
                  ((. (require :colorful-menu) :blink_components_highlight) ctx)))
          (init label :text
                (fn [ctx]
                  ((. (require :colorful-menu) :blink_components_text) ctx)))
          (init label :width :max
                (fn [ctx]
                  (or (and (= ctx.mode :cmdline) 22) 60))))
        (let [provider (init menu :draw :components :provider {})]
          (init provider :highlight :Fg)
          (init provider :text
                (fn [ctx]
                  (let [sub (: (ctx.item.source_name:sub 1 3) :upper)]
                    (.. "[" sub "]")))))))
    (init completion :trigger :show_on_x_blocked_trigger_characters
          ["'" "\"" "(" "{"]))
  (let [sources (init cfg :sources {})]
    (init sources :default
          (fn []
            (local (success node) (pcall vim.treesitter.get_node))
            (if (= vim.bo.filetype :lua) [:lsp :path :lazydev]
                (and (and success node)
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
    (kset keymap :<Up> [:select_prev :fallback])
    (let [cmdline (init keymap :cmdline {})
          feedkeys vim.api.nvim_feedkeys]
      (kset cmdline :<C-j> [:select_next :fallback])
      (kset cmdline :<C-k> [:select_prev :fallback])
      (kset cmdline :<S-Tab> [:select_prev :fallback])
      (kset cmdline :<Tab> [:select_next :fallback])
      (kset cmdline :<CR> [#($1.accept {:callback #(feedkeys "\n" :n true)})
                           :fallback])))
  (let [fuzzy (init cfg :fuzzy {})]
    (init fuzzy :prebuilt_binaries {:ignore_version_mismatch true}))
  (let [snippets (init cfg :snippets {})]
    (init snippets :active
          (fn [filter]
            (when (and filter filter.direction)
              (. (require :luasnip) :locally_jumpable))
            ((. (require :luasnip) :in_snippet))))
    (init snippets :expand
          (fn [snippet]
            ((. (require :luasnip) :lsp_expand) snippet)))
    (init snippets :jump
          (fn [direction]
            ((. (require :luasnip) :jump) direction)))))

{1 :Saghen/blink.cmp
 : opts
 :build "cargo build --release"
 :dependencies [:PaterJason/cmp-conjure
                :zbdmw/colorful-menu.nvim
                {1 :saghen/blink.compat}]
 :event [:CursorHold :CursorHoldI :CmdlineEnter "User AfterLoad"]
 :opts_extend [:sources.completion.enabled_providers]}
