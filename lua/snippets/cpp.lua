local s = require("luasnip").snippet
local t = require("luasnip").text_node
local f = require("luasnip").function_node
local fmt = require("luasnip.extras.fmt").fmt
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix
local expr_query = [[
            [
              (if_statement)
              (call_expression)
              (identifier)
              (declaration)
              (type_identifier)
              (template_function)
              (subscript_expression)
              (field_expression)
              (user_defined_literal)
            ] @prefix
]]
local cout = treesitter_postfix(
  {
    trig = ".cout",
    matchTSNode = {
      query = expr_query,
      query_lang = "cpp",
      select = "longest",
    },
    reparseBuffer = "live",
    snippetType = "autosnippet",
  },
  fmt(
    [[
          std::cout << {expr} << std::endl;
      ]],
    {
      expr = f(function(_, parent) return parent.snippet.env.LS_TSMATCH end, {}),
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
  cout,
  acm,
}
