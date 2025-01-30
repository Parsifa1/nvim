(local ls (require :luasnip))
(local s ls.snippet)
(local t ls.text_node)
(local endl (s :endd [(t "'\\n'")]))
(local cout (s :cout [(t "std::cout")]))
(local chmax
       (s :chmax
          [(t "inline bool chmax(auto &a, auto b) { return (a < b) ? a = b, true : false; }")]))

(local chmin
       (s :chmin
          [(t "inline bool chmin(auto &a, auto b) { return (a > b) ? a = b, true : false; }")]))

(local fread (s :fread [(t ["inline auto read() {"
                            "    std::cin.tie(nullptr)->sync_with_stdio(false); "
                            "    return [](auto x) { return std::cin >> x, x; }(0ll); "
                            "}"])]))

(local acm (s :acm [(t ["#include <bits/stdc++.h>"
                        "using i64 = long long;"
                        "constexpr i64 INF = 1e18;"
                        ""
                        "inline auto read() {"
                        "    std::cin.tie(nullptr)->sync_with_stdio(false);"
                        "    return [](auto x) { return std::cin >> x, x; }(0ll);"
                        "}"
                        ""
                        "void solve() {"
                        ""
                        "}"
                        ""
                        "signed main() {"
                        "    int T = read();"
                        "    while (T--) solve();"
                        "}"])]))

(values [fread chmax chmin] [endl cout acm])
