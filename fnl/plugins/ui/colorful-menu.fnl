{1 :xzbdmw/colorful-menu.nvim
 :config (fn []
           ((. (require :colorful-menu) :setup) {:fallback_highlight "@variable"
                                                 :ls {:basedpyright {:extra_info_hl "@comment"}
                                                      :clangd {:extra_info_hl "@comment"}
                                                      :fallback true
                                                      :gopls {:add_colon_before_type false
                                                              :align_type_to_right true}
                                                      :lua_ls {:arguments_hl "@comment"}
                                                      :roslyn {:extra_info_hl "@comment"}
                                                      :rust-analyzer {:extra_info_hl "@comment"}
                                                      :ts_ls {:extra_info_hl "@comment"}
                                                      :vtsls {:extra_info_hl "@comment"}}
                                                 :max_width 60}))}
