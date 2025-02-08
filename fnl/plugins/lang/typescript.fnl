(local mason-path (.. (vim.fn.stdpath :data) :/mason/packages/))
(local ft [:typescript
           :javascript
           :javascriptreact
           :typescriptreact
           :vue
           :markdown.mdx])

{1 :parsifa1/typescript-tools.nvim
 :dependencies :nvim-lua/plenary.nvim
 : ft
 :opts {:filetypes ft
        :settings {:separate_diagnostic_server true
                   :publish_diagnostic_on :change
                   :tsserver_file_preferences {:includeInlayParameterNameHints :literals
                                               :includeInlayEnumMemberValueHints true
                                               :includeInlayFunctionLikeReturnTypeHints true
                                               :includeInlayFunctionParameterTypeHints true
                                               :includeInlayPropertyDeclarationTypeHints true
                                               :includeInlayVariableTypeHints true}}
        :tsserver_plugins [{:name "@vue/typescript-plugin"
                            :Fath (.. mason-path :vue-language-server
                                      "/node_modules/@vue/language-server")}
                           {:name "@mdxjs/typescript-plugin"
                            :path (.. mason-path :mdx-analyzer
                                      "/node_modules/@mdx/language-server")}]}}
