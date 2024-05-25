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
local endl = s("endd", { t "'\\n';" })
local cout = s("cout", { t "std::cout" })
local acm = s("acm", {
    t {
        "#include <bits/extc++.h>",
        "using i64 = long long;",
        "constexpr i64 INF = 1e18;",
        "",
        "template <typename... Args>",
        "void println(std::format_string<Args...> fmt, Args&&... args) {",
        "    std::cout << std::format(fmt, std::forward<Args>(args)...) << '\\n';",
        "}",
        "",
        "inline i64 read() {",
        "    i64 x = 0, w = 1, ch = std::cin.get();",
        "    for (; (ch >= '0' && ch <= '9') || ch == '-'; ch = std::cin.get())",
        "        ch == '-' ? w = -1 : x = (x * 10 + ch - '0');",
        "    return x * w;",
        "}",
        "",
        "void solve() {",
        "",
        "}",
        "",
        "signed main() {",
        "    std::cin.tie(nullptr)->sync_with_stdio(false);",
        "    int T = read();",
        "    while (T--) solve();",
        "}",
    },
})
return {}, {
    -- iter,
    -- itit,
    endl,
    cout,
    acm,
}
