(local custom (require :custom))

(local keys
       (fn []
         (local float-opts {:border custom.border})
         (local lazygit
                (: (. (require :toggleterm.terminal) :Terminal) :new
                   {:cmd :lazygit
                    :direction :float
                    :float_opts float-opts
                    :hidden true
                    :on_create (fn [t] (local bufnr t.bufnr)
                                 (vim.keymap.set :t :<Esc> :<Esc>
                                                 {:buffer bufnr}))}))
         (local yazi
                (: (. (require :toggleterm.terminal) :Terminal) :new
                   {:cmd :yazi
                    :direction :float
                    :float_opts float-opts
                    :hidden true
                    :on_create (fn [t] (local bufnr t.bufnr)
                                 (vim.keymap.set :t :<Esc> :<Esc>
                                                 {:buffer bufnr}))}))
         [["<C-\\>"]
          {1 "`" 2 :<cmd>ToggleTerm<CR> :desc :Terminal :mode [:n :t]}
          {1 "`"
           2 (fn []
               (vim.cmd :ToggleTerm)
               (when (= (vim.fn.mode) :n) (vim.cmd :startinsert)))
           :desc :Terminal
           :mode :t}
          {1 :<leader>gl 2 (fn [] (lazygit:toggle)) :desc :LazyGit}
          {1 :<leader>gf 2 (fn [] (yazi:toggle)) :desc :Yazi}]))

{1 :akinsho/toggleterm.nvim
 : keys
 :opts {:float_opts {:border custom.border}
        :on_create (fn [t] (local bufnr t.bufnr)
                     (vim.keymap.set :t :<Esc> "<C-\\><C-N>" {:buffer bufnr}))
        :open_mapping "<c-\\>"
        :shade_terminals false
        :shell (if (= (. (vim.uv.os_uname) :sysname) :Windows_NT)
                   "pwsh -nologo"
                   :fish)
        :size (fn [term]
                (if (= term.direction :horizontal) 16
                    (= term.direction :vertical) (* vim.o.columns 0.4)))}}
