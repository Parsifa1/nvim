{1 :kawre/leetcode.nvim
 :build ":TSUpdate html"
 :cmd :Leet
 :dependencies [:nvim-treesitter/nvim-treesitter]
 :opts {:cn {:enabled true}
        :lang :cpp
        :injector {:cpp {:after "int main() {}"
                         :before ["#include <bits/stdc++.h>"
                                  "using namespace std;"]}}}}
