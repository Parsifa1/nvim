(local opts {:all_frames false
             :all_references false
             :clear_on_continue false
             :commented false
             :display_callback (fn [variable _ _ _ options]
                                 (if (= options.virt_text_pos :inline)
                                     (.. " = " variable.value)
                                     (.. variable.name " = " variable.value)))
             :enabled true
             :enabled_commands true
             :highlight_changed_variables true
             :highlight_new_as_changed false
             :show_stop_reason true
             :virt_lines false
             :virt_text_pos (if (= (vim.fn.has :nvim-0.10) 1) :inline :eol)
             :virt_text_win_col nil})

{1 :theHamsta/nvim-dap-virtual-text
 :dependencies [:mfussenegger/nvim-dap]
 : opts}
