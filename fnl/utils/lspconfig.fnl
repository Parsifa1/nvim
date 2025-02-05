(local M {})
(set M.config {})

(fn conf [name cfg]
  (tset M.config name cfg))

(let []
  ;; astro
  (conf :astro {:settings {:astro {:content-intellisense true}}})
  ;; clangd
  (let [flag [:-std=c++2b
              :-xc++
              :-Wall
              :-Wno-unused-variable
              :-Wno-vla-cxx-extension
              "-Wno-unknown-attributes  "
              "-Wno-unused-but-set-variable "
              :-fsyntax-only
              :-static-libgcc
              "-l stdc++"]
        cmd [:clangd
             :--clang-tidy
             :--completion-style=detailed
             :--header-insertion=never
             :--offset-encoding=utf-16
             :--function-arg-placeholders=0]]
    (conf :clangd {: cmd
                   :filetypes [:cpp :c]
                   :init_options {:fallbackFlags flag}}))
  ;; fennel_language_server
  (conf :fennel_language_server
        {:settings {:fennel {:diagnostics {:globals [:vim :MiniFiles :Snacks]}
                             :workspace {:checkThirdParty false
                                         :library (vim.api.nvim_list_runtime_paths)}}}})
  ;; hls
  (conf :hls
        {:root_dir (fn [] (vim.fn.getcwd))
         :settings {:haskell {:plugin {:semanticTokens {:globalOn true}}}}})
  ;; lua_ls
  (conf :lua_ls {:settings {:Lua {:diagnostics {:disable [:missing-fields
                                                          :incomplete-signature-doc]}
                                  :hint {:arrIndex :Enable
                                         :enable true
                                         :setType true}}}})
  ;; nil_ls
  (conf :nil_ls {:settings {:nil {:nix {:flake {:autoArchive true}}}}})
  ;; omnisharp
  (conf :omnisharp {:cmd [:dotnet
                          (.. (: ((. (require :mason-registry) :get_package) :omnisharp)
                                 :get_install_path)
                              :/libexec/Omnisharp.dll)]
                    :enable_import_completion true
                    :enable_roslyn_analyzers true
                    :handlers {:textDocument/definition (fn [...]
                                                          ((. (require :omnisharp_extended)
                                                              :handler) ...))}
                    :keys [{1 :gd
                            2 (fn []
                                ((. (require :omnisharp_extended)
                                    :telescope_lsp_definitions)))
                            :desc "Goto Definition"}]
                    :organize_imports_on_format true})
  ;; pyright
  (conf :pyright
        {:cmd [:delance-langserver :--stdio]
         :settings {:python {:analysis {:extraPaths [(vim.fn.getcwd)]
                                        :ignore ["*"]
                                        :inlayHints {:callArgumentNames :partial
                                                     :functionReturnTypes true
                                                     :pytestParameters true
                                                     :variableTypes true}}
                             :disableOrganizeImports true
                             :pythonPath (vim.fn.exepath :python)}}})
  ;; tailwindcss
  (conf :tailwindcss {:filetypes [:html
                                  :css
                                  :javascript
                                  :javascriptreact
                                  :typescript
                                  :typescriptreact
                                  :astro]})
  ;; tinymist
  (conf :tinymist {:cmd [:tinymist]
                   :root_dir (fn [] (vim.fn.getcwd))
                   :settings {}
                   :single_file_support true})
  ;; ts_ls
  (let [ft [:typescript :javascript :javascriptreact :typescriptreact :vue]
        path (fn [lang tail]
               (.. (: ((. (require :mason-registry) :get_package) lang)
                      :get_install_path) tail))
        plugins [{:name "@vue/typescript-plugin"
                  :location (path :vue-language-server
                                  "/node_modules/@vue/language-server")
                  :languages :vue}
                 {:name "@mdxjs/typescript-plugin"
                  :location (path :mdx-analyzer
                                  "/node_modules/@mdx/language-server")
                  :languages :mdx}]]
    (conf :ts_ls {:filetypes ft :init_options {: plugins}}))
  ;; verible
  (conf :verible {:cmd [:verible-verilog-ls
                        :--rules=-explicit-parameter-storage-type]
                  :root_dir (fn [] (vim.fn.getcwd))})
  (conf :astro {:settings {:astro {:content-intellisense true}}}))

M
