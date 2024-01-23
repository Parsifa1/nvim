---@diagnostic disable: undefined-global
local print = postfix(".println", {
    f(function(_, parent)
        return "println!(\"{:?}\", " .. parent.snippet.env.POSTFIX_MATCH .. ");"
    end, {}),
})

return {
    print,
}
