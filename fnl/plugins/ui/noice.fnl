{1 :folke/noice.nvim
 :dependencies [:MunifTanjim/nui.nvim :rcarriga/nvim-notify]
 :event "User AfterLoad"
 :keys [{1 :<leader>n 2 :<cmd>NoiceAll<CR> :desc "open Noice"}]
 :opts {:cmdline {:view :cmdline}
        :lsp {:hover {:enabled true :silent true}
              :override {:cmp.entry.get_documentation false
                         :vim.lsp.util.convert_input_to_markdown_lines true
                         :vim.lsp.util.stylize_markdown true}
              :progress {:enabled false}
              :signature {:enabled false}}
        :presets {:bottom_search true
                  :command_palette false
                  :long_message_to_split true
                  :lsp_doc_border true}
        :routes [{:filter {:event :msg_show :min_height 20} :view :split}
                 {:filter {:any [{:find :W10}
                                 {:find :E21}
                                 {:find :E492}
                                 {:find :E486}
                                 {:find "^/[^/]+"}
                                 {:find "%d+L, %d+B"}
                                 {:find "; after #%d+"}
                                 {:find "; before #%d+"}
                                 {:find "%d fewer lines"}
                                 {:find "%d more lines"}
                                 {:find "Index out of bounds"}]
                           :event :msg_show}
                  :opts {:skip true}}
                 {:filter {:any [{:find :position_encoding}
                                 {:find "Delete existing terminal"}
                                 {:find :telescope.builtin.buffers}
                                 {:find "No matching notification found to replace"}
                                 {:find "Compilation complete"}]
                           :event :notify}
                  :opts {:skip true}}]
        :views {:confirm {:position {:row "50%"}} :hover {:scrollbar false}}}}
