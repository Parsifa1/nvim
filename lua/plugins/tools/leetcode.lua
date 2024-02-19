return {
    "kawre/leetcode.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = ":TSUpdate html",
    cmd = "Leet",
    opts = {
        lang = "cpp",
        cn = {
            enabled = true,
        },
        injector = {
            ["cpp"] = {
                before = { "#include <bits/stdc++.h>", "using namespace std;" },
                after = "int main() {}",
            },
        },
    },
}
