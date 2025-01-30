(local (mode-n mode-v mode-i mode-o mode-s mode-t)
       (values [:n] [:v] [:i] [:o] [:s] [:t]))

(local (mode-nv mode-ni mode-nit mode-nvo)
       (values [:n :v] [:n :i] [:n :i :v] [:n :v :o]))

;; fnlfmt: skip
(local keymap [
               {:from :n :mode mode-n :to :nzzzv}
               {:from :j :mode mode-n :to :gj}
               {:from :k :mode mode-n :to :gk}
               {:from :H :mode mode-nvo :to "^"}
               {:from :L :mode mode-nvo :to "$"}
               {:from "=" :mode mode-nv :to :gq}
               {:from "=" :mode mode-o :to :q}
               {:from :<BS> :mode mode-s :to "<BS>:startinsert<CR>"}
               {:from :<Esc> :mode mode-t :to "<C-\\><C-N>"}
               {:from :K :mode mode-v :to ":m '<-2<cr>gv=gv"}
               {:from :J :mode mode-v :to ":m '>+1<cr>gv=gv"}
               {:from :<A-l> :mode mode-i :to :<Right>}
               {:from :<A-h> :mode mode-i :to :<Left>}
               {:from :<C-f> :mode mode-i :to "<cmd>lua require('luasnip').expand()<CR>"}
               {:from :<C-h> :mode mode-nit :to :<C-w>h}
               {:from :<C-j> :mode mode-nit :to :<C-w>j}
               {:from :<C-k> :mode mode-nit :to :<C-w>k}
               {:from :<C-l> :mode mode-nit :to :<C-w>l}
               {:from :<C-i> :mode mode-n :to :<C-i>}
               {:from :<C-c> :mode mode-v :to "\"+y"}
               {:from :<C-Up> :mode mode-n :to "<cmd>res +3<CR>"}
               {:from :<C-Down> :mode mode-n :to "<cmd>res -3<CR>"}
               {:from :<C-Left> :mode mode-n :to "<cmd>vertical resize -3<CR>"}
               {:from :<C-Right> :mode mode-n :to "<cmd>vertical resize +3<CR>"}
               {:from :<C-s> :mode mode-ni :to :<cmd>write<CR>}
               {:from :<C-a> :mode mode-ni :to "<cmd>normal gg0vG$<CR>"}
               {:from :<F1> :mode mode-ni :to "<cmd>CompetiTest run<CR>"}
               {:from :<F2> :mode mode-ni :to "<cmd>CompetiTest add_testcase<CR>"}
               {:from :<F3> :mode mode-ni :to "<cmd>CompetiTest edit_testcase<CR>"}
               {:from :<F4> :mode mode-ni :to "<cmd>AsyncTask acm<cr>"}
               {:from :<F5> :mode mode-ni :to "<cmd>AsyncTask run<cr>"}
               {:from :<F6> :mode mode-ni :to "<cmd>AsyncTask build<cr>"}
               {:from :<A-q> :mode mode-nit :to :<cmd>q<CR>}
               {:from :<C-x> :mode mode-n :to "<cmd>lua require('snacks.bufdelete').delete()<CR>"}
               {:from :<A-Q> :mode mode-nit :to :<cmd>qa<CR>}
               {:from :zh :mode mode-n :to :<C-w>h :desc "Go to the left window"}
               {:from :zj :mode mode-n :to :<C-w>j :desc "Go to the down window"}
               {:from :zk :mode mode-n :to :<C-w>k :desc "Go to the up window"}
               {:from :zl :mode mode-n :to :<C-w>l :desc "Go to the right window"}
               {:from :zc :mode mode-n :to :<C-w>c :desc "close current window"}
               {:from :zs :mode mode-n :to :<C-w>s :desc "split current window"}
               {:from :zv :mode mode-n :to :<C-w>v :desc "vsplit current window"}
               {:from :<leader>bd :mode mode-n :to :<cmd>bd<CR> :desc "[B]uffer [D]elete"}
               {:from :<leader>sw :mode mode-n :to "<cmd>set wrap!<CR>" :desc "toggle warp"}
               {:from :<leader><leader> :mode mode-n :to :<cmd>noh<CR> :desc "clear highlight"}
               {:from :zo :mode mode-n :to :<C-w>o} {:desc :lazy :from :<leader>p :mode mode-n :to :<cmd>Lazy<CR> :desc "only current window"}
               {:from :<leader>ss :mode mode-n :noise true :to ":%s/\\<<C-r><C-w>\\>//g<left><left>" :desc "global replacement"}])

(each [_ mapping (ipairs keymap)]
  (let [to mapping.to
        desc mapping.desc
        mode mapping.mode
        from mapping.from
        kset vim.keymap.set]
    (if desc
        (kset mode from to {:desc mapping.desc :noremap true :silent true})
        (kset mode from to {:noremap true :silent true}))
    (when (= mapping.noise true)
      (kset mode from to {:noremap true}))))
