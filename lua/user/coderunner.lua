local win = require "user.floaterm"
local function split()
    win:Create({
        width = 0.36,
        height = 0.87,
        title = " Code Running ",
    }, {
        buflisted = true,
        pos = "tr",
    })
end

local function run(cmd)
    split()
    cmd = "term " .. cmd
    vim.cmd(cmd)
end

vim.api.nvim_set_var("Coderunner", run)

vim.cmd [[
function! s:coderunner(opts)
    autocmd TermOpen * startinsert
    let l:Run_function = luaeval("vim.api.nvim_get_var('Coderunner')")
    call l:Run_function(a:opts.cmd)
endfunction

let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.coderunner = function('s:coderunner')
]]
