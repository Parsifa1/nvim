(local ins [:cpp
            :lua
            :rust
            :python
            :vim
            :regex
            :bash
            :markdown_inline
            :comment
            :yaml
            :latex
            :markdown
            :fish
            :html
            :css
            :javascript
            :typescript
            :nix
            :typst
            :vue
            :astro
            :vimdoc])

(local keymaps
       {:aa {:desc "a argument"
             :query "@parameter.outer"
             :ac "@class.outer"
             :af "@function.outer"
             :ai "@conditional.outer"
             :al {:desc "a loop" :query "@loop.outer"}
             :ar {:desc "a return" :query "@return.outer"}
             :ia {:desc "inner part of a argument" :query "@parameter.inner"}
             :ic {:desc "Select inner part of a class region"
                  :query "@class.inner"}
             :if "@function.inner"
             :ii "@conditional.inner"
             :il {:desc "inner part of a loop" :query "@loop.inner"}
             :ir {:desc "inner return" :query "@return.outer"}}})

{1 :nvim-treesitter/nvim-treesitter
 :build ":TSUpdate"
 :cmd [:TSUpdate :TSInstall :TSInstallInfo]
 :config (fn []
           (tset (require :nvim-treesitter.install) :prefer_git true)
           (let [ts (. (require :nvim-treesitter.configs) :setup)]
             (ts {:auto_install true
                  :ensure_installed ins
                  :highlight {:additional_vim_regex_highlighting false
                              ; :disable [:latex]
                              :enable true}
                  :textobjects {:select {: keymaps
                                         :enable true
                                         :lookahead true
                                         :include_surrounding_whitespace false
                                         :selection_modes {"@class.outer" :<c-v>
                                                           "@function.outer" :V
                                                           "@parameter.outer" :v}}}
                  :textsubjects {:enable true
                                 :keymaps {:. :textsubjects-smart
                                           ";" :textsubjects-container-outer
                                           "i;" {1 :textsubjects-container-inner
                                                 :desc "Select inside containers"}}
                                 :prev_selection ","}})))
 :dependencies [:RRethy/nvim-treesitter-textsubjects
                :nvim-treesitter/nvim-treesitter-textobjects]
 :event [:BufNewFile :BufRead]}
