{1 :xeluxee/competitest.nvim
 :dependencies :MunifTanjim/nui.nvim
 :ft [:cpp :c :rust :python]
 :opts {:compile_command {:cpp {:args ["$(FNAME)"
                                       :-std=c++23
                                       :-o
                                       "bin/$(FNOEXT)"]
                                :exec :g++}}
        :editor_ui {:insert_mode_mappings {:save_and_close :<C-s>
                                           :switch_window [:<A-h>
                                                           :<A-l>
                                                           :<C-i>]}
                    :normal_mode_mappings {:cancel [:q :Q :<esc> :<F1>]
                                           :switch_window [:<C-h>
                                                           :<C-l>
                                                           :<C-i>]}}
        :run_command {:cpp {:exec "./bin/$(FNOEXT)"}}
        :runner_ui {:close [:q :Q :<esc>]}
        :save_current_file true
        :testcases_directory :/bin
        :testcases_use_single_file true}}
