local s = require("luasnip").s
local i = require("luasnip").i
local t = require("luasnip").t
local d = require("luasnip").d
local sn = require("luasnip").sn
return {
  s({ trig = "table(%d+)x(%d+)", regTrig = true }, {
    d(1, function(_, snip)
      local nodes = {}
      local i_counter = 0
      local hlines = ""
      for _ = 1, snip.captures[2] do
        i_counter = i_counter + 1
        table.insert(nodes, t "| ")
        table.insert(nodes, i(i_counter, "Column" .. i_counter))
        table.insert(nodes, t " ")
        hlines = hlines .. "|---"
      end
      table.insert(nodes, t { "|", "" })
      hlines = hlines .. "|"
      table.insert(nodes, t { hlines, "" })
      for _ = 1, snip.captures[1] do
        for _ = 1, snip.captures[2] do
          i_counter = i_counter + 1
          table.insert(nodes, t "| ")
          table.insert(nodes, i(i_counter))
          table.insert(nodes, t " ")
        end
        table.insert(nodes, t { "|", "" })
      end
      return sn(nil, nodes)
    end),
  }),
}
