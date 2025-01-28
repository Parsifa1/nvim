(local custom (require :custom))
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

(local opts {:appearance {:kind_icons custom.icons.kind
                          :use_nvim_cmp_as_default true}
             :completion {:accept {:auto_brackets {:enabled true
                                                   :kind_resolution {:blocked_filetypes [:typescriptreact
                                                                                         :javascriptreact
                                                                                         :vue
                                                                                         :rust]
                                                                     :enabled true}}}
                          :documentation {:auto_show true
                                          :window {:border :single
                                                   :scrollbar false}}
                          :list {:selection {:auto_insert (fn [ctx]
                                                            (= ctx.mode
                                                               :cmdline))
                                             :preselect (fn [ctx]
                                                          (not= ctx.mode
                                                                :cmdline))}}
                          :menu {:border :single
                                 :draw {:columns (fn [ctx]
                                                   (or (and (= ctx.mode
                                                               :cmdline)
                                                            [[:kind_icon]
                                                             [:label]])
                                                       [[:kind_icon]
                                                        {1 :label :gap 1}
                                                        [:provider]]))
                                        :components {:label {:highlight (fn [ctx]
                                                                          ((. (require :colorful-menu)
                                                                              :blink_components_highlight) ctx))
                                                             :text (fn [ctx]
                                                                     ((. (require :colorful-menu)
                                                                         :blink_components_text) ctx))
                                                             :width {:max (fn [ctx]
                                                                            (or (and (= ctx.mode
                                                                                        :cmdline)
                                                                                     24)
                                                                                60))}}
                                                     :provider {:highlight :Fg
                                                                :text (fn [ctx]
                                                                        (.. "["
                                                                            (: (ctx.item.source_name:sub 1
                                                                                                         3)
                                                                               :upper)
                                                                            "]"))}}
                                        :treesitter [:lsp]}
                                 :scrollbar false
                                 :winhighlight "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None"}
                          :trigger {:show_on_x_blocked_trigger_characters ["'"
                                                                           "\""
                                                                           "("
                                                                           "{"]}}
             :fuzzy {:prebuilt_binaries {:ignore_version_mismatch true}}
             :keymap {:<C-CR> [:fallback]
                      :<C-d> [:scroll_documentation_down :fallback]
                      :<C-j> [:select_next :fallback]
                      :<C-k> [:select_prev :fallback]
                      :<C-u> [:scroll_documentation_up :fallback]
                      :<C-w> [:show
                              :hide
                              :show_documentation
                              :hide_documentation]
                      :<CR> [:accept :fallback]
                      :<Down> [:select_next :fallback]
                      :<S-Tab> (super-tab :backward)
                      :<Tab> (super-tab :forward)
                      :<Up> [:select_prev :fallback]
                      :cmdline {:<C-j> [:select_next :fallback]
                                :<C-k> [:select_prev :fallback]
                                :<CR> [(fn [cmp]
                                         (cmp.accept {:callback (fn []
                                                                  (vim.api.nvim_feedkeys "\n"
                                                                                         :n
                                                                                         true))}))
                                       :fallback]
                                :<S-Tab> [:select_prev :fallback]
                                :<Tab> [:select_next :fallback]}}
             :signature {:enabled true :window {:border :single}}
             :snippets {:active (fn [filter]
                                  (when (and filter filter.direction)
                                    (let [___antifnl_rtns_1___ [((. (require :luasnip)
                                                                    :locally_jumpable))]]
                                      (lua "return (table.unpack or _G.unpack)(___antifnl_rtns_1___)")))
                                  ((. (require :luasnip) :in_snippet)))
                        :expand (fn [snippet]
                                  ((. (require :luasnip) :lsp_expand) snippet))
                        :jump (fn [direction]
                                ((. (require :luasnip) :jump) direction))}
             :sources {:default (fn []
                                  (local (success node)
                                         (pcall vim.treesitter.get_node))
                                  (if (= vim.bo.filetype :lua) [:lsp :path]
                                      (and (and success node)
                                           (vim.tbl_contains [:comment
                                                              :line_comment
                                                              :block_comment]
                                                             (node:type)))
                                      [:buffer] [:lsp :path :snippets :buffer]))
                       :providers {:lazydev {:module :lazydev.integrations.blink
                                             :name :Development}}}})

{1 :Saghen/blink.cmp
 :build "cargo build --release"
 :dependencies [:xzbdmw/colorful-menu.nvim]
 :event [:CursorHold :CursorHoldI :CmdlineEnter "User AfterLoad"]
 : opts
 :opts_extend [:sources.completion.enabled_providers]}
