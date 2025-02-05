(local lazy-status (require :lazy.status))
(local custom (require :custom))
(local lualine-modes [:insert
                      :normal
                      :visual
                      :command
                      :replace
                      :inactive
                      :terminal])

(fn lsp []
  (var clients (vim.lsp.get_clients))
  (local buf (vim.api.nvim_get_current_buf))
  (set clients (: (: (: (: (vim.iter clients) :filter
                           (fn [client] (. client.attached_buffers buf)))
                        :filter
                        (fn [client] (not= client.name "GitHub Copilot")))
                     :map (fn [client] client.name)) :totable))
  (local info (table.concat clients ", "))
  info)

(local opts {:extensions [:oil
                          :man
                          :quickfix
                          :neo-tree
                          :symbols-outline
                          :aerial
                          :fugitive
                          :nvim-dap-ui
                          :mason
                          :mundo
                          :lazy
                          :trouble
                          :toggleterm]
             :options {:always_divide_middle true
                       :component_separators {:left "" :right ""}
                       :disabled_filetypes [:snacks_dashboard
                                            :TelescopePrompt
                                            :mason]
                       :globalstatus true
                       :icons_enabled true
                       :section_separators {:left "" :right ""}}
             :sections {:lualine_a [{1 (fn []
                                         (if vim.bo.modified " " "󰄳 "))
                                     :padding {:left 0 :right 0}
                                     :separator {:left "" :right ""}}
                                    {1 :mode
                                     :padding {:left 0 :right 0}
                                     :separator {:left "" :right ""}}]
                        :lualine_b [{1 :branch :icon ""}]
                        :lualine_c [{1 :filetype
                                     :colored true
                                     :icon {:align :left}
                                     :icon_only true
                                     :padding {:left 1 :right 0}}
                                    lsp
                                    {1 :diagnostics
                                     :symbols {:error custom.icons.diagnostic.Error
                                               :hint custom.icons.diagnostic.Hint
                                               :info custom.icons.diagnostic.Information
                                               :warn custom.icons.diagnostic.Warning}}
                                    (fn [] (if vim.bo.readonly " " ""))]
                        :lualine_x [{1 :diff
                                     :symbols {:added " "
                                               :modified " "
                                               :removed " "}}
                                    {1 lazy-status.updates
                                     :color {:fg "#ff9e64"}
                                     :cond lazy-status.has_updates}
                                    (fn []
                                      (var reg (vim.fn.reg_recording))
                                      (when (not= reg "")
                                        (let [___antifnl_rtn_1___ (.. "recording @"
                                                                      reg)]
                                          (lua "return ___antifnl_rtn_1___")))
                                      (set reg (vim.fn.reg_recorded))
                                      (when (not= reg "")
                                        (let [___antifnl_rtn_1___ (.. "recorded @"
                                                                      reg)]
                                          (lua "return ___antifnl_rtn_1___")))
                                      "")
                                    {1 :copilot
                                     :show_running true
                                     :symbols {:status {:disabled " "
                                                        :enabled " "}}}]
                        :lualine_y [{1 :encoding :right_padding 2}]
                        :lualine_z [{1 :location :padding 0}
                                    {1 (fn []
                                         (local cursorcol (vim.fn.virtcol "."))
                                         (if (>= cursorcol 10) " · " "· "))
                                     :padding 0}
                                    {1 :progress
                                     :icon {1 "󰇽" :align :left}
                                     :padding {:left 0 :right 1}
                                     :separator {:right ""}}]}})

{1 :nvim-lualine/lualine.nvim
 :config (fn []
           (local auto (require :lualine.themes.auto))
           (each [_ field (ipairs lualine-modes)]
             (when (and (. auto field) (. auto field :c))
               (tset (. auto field :c) :bg :NONE)))
           (set opts.options.theme auto)
           ((. (require :lualine) :setup) opts))
 :dependencies :ofseed/copilot-status.nvim
 :event [:BufRead :BufNewFile]}
