---@diagnostic disable: undefined-global
return {
    postfix(".bold", {
        f(function(_, parent) return "bold(" .. parent.snippet.env.POSTFIX_MATCH .. ")" end, {}),
    }),
}
