---@diagnostic disable: undefined-global, unused-local
local iter = s(
    {
        trig = "iter",
        dsrc = "Iterate range (C++11)",
    },
    fmta(
        [[
for (6auto_type9 6var9 : 6container9) {
    6ends9
}
]],
        {
            -- TODO: Query var type
            auto_type = i(1, "auto"),
            container = i(3, "range"),
            var = i(2, "item"),
            ends = i(0),
        },
        {
            delimiters = "69",
        }
    )
)

local itit = s(
    {
        trig = "itit",
        dsrc = "Iterate using begin/end member functions",
    },
    fmta(
        [[
for (6iter_type9 6iter9 = 6container9.begin(); 6copy_iter9 != 6copy_container9.end(); ++6copy_iter9) {
6ends9
    }
    ]],
        {
            -- TODO: Query var type
            iter_type = i(2, "auto"),
            iter = i(3, "begin"),
            container = i(1, "container"),
            copy_iter = f(text_same_with, 3),
            copy_container = f(text_same_with, 1),
            ends = i(0),
        },
        {
            delimiters = "69",
        }
    )
)
local endl = s("endd", { t "'\\n'" })
local chmax = s("chmax", { t "inline bool chmax(auto &a, auto b) { return (a < b) ? a = b, true : false; }" })
local chmin = s("chmin", { t "inline bool chmin(auto &a, auto b) { return (a > b) ? a = b, true : false; }" })
local fread = s("fread", {
    t {
        "inline auto read() {",
        "    std::cin.tie(nullptr)->sync_with_stdio(false); ",
        "    return [](auto x) { return std::cin >> x, x; }(0ll); ",
        "}",
    },
})
local acm = s("acm", {
    t {
        "#include <bits/stdc++.h>",
        "using i64 = long long;",
        "constexpr i64 INF = 1e18;",
        "",
        "inline auto read() {",
        "    std::cin.tie(nullptr)->sync_with_stdio(false);",
        "    return [](auto x) { return std::cin >> x, x; }(0ll);",
        "}",
        "",
        "void solve() {",
        "",
        "}",
        "",
        "signed main() {",
        "    int T = read();",
        "    while (T--) solve();",
        "}",
    },
})
return {
    fread,
    chmax,
    chmin,
}, {
    endl,
    acm,
}
