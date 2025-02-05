;; @author: Parsifa1
(local FloatWin {})

(fn getpos [width height pos ui]
  (var x 0)
  (var y 0)
  (var anchor "")
  (if (= (type pos) :string)
      (do
        (match (pos:sub 1 1)
          :c (do
               (set anchor (.. anchor :N))
               (set x (math.ceil (/ (- ui.height height) 2))))
          :t (do
               (set anchor (.. anchor :N))
               (set x 1))
          :b (do
               (set anchor (.. anchor :S))
               (set x (- ui.height 1))))
        (match (pos:sub 2 2)
          :c (do
               (set anchor (.. anchor :W))
               (set y (math.ceil (/ (- ui.width width) 2))))
          :l (do
               (set anchor (.. anchor :W))
               (set y 0))
          :r (do
               (set anchor (.. anchor :E))
               (set y ui.width))))
      (do
        (set x (. pos 1))
        (set y (. pos 2))))
  (values x y anchor))

(fn update [win val ui]
  (when (and (< 0 win.width) (< win.width 1))
    (tset win :width (math.ceil (* ui.width win.width))))
  (when (and (< 0 win.height) (< win.height 1))
    (tset win :height (math.ceil (* ui.height win.height))))
  (when val.lines
    (each [_ v (ipairs val.lines)]
      (tset win :width (math.max win.width (vim.fn.strchars v))))
    (tset win :height (math.max win.height (length val.lines))))
  (tset win :height (math.min win.height ui.height))
  (tset win :width (math.min win.width ui.width))
  win)

(fn float-win-opt [opt val]
  (let [ui (. (vim.api.nvim_list_uis) 1)
        win (vim.tbl_extend :force
                            {:anchor :NW
                             :relative :editor
                             :width (math.ceil (/ ui.width 2))
                             :height (math.ceil (/ ui.height 2))
                             :style :minimal
                             :border :rounded
                             :title ""
                             :title_pos :center}
                            (or opt {}))]
    (let [updated-win (update win val ui)
          (row col anchor) (getpos win.width win.height val.pos ui)]
      (tset updated-win :row row)
      (tset updated-win :col col)
      (tset updated-win :anchor anchor)
      updated-win)))

(fn FloatWin.GetInfo []
  {:width FloatWin.win.width
   :height FloatWin.win.height
   :col FloatWin.win.col
   :row FloatWin.win.row
   :bufnr FloatWin.bufnr
   :winnr FloatWin.winnr})

(fn FloatWin.Create [_ opt val]
  (let [val (vim.tbl_extend :force {:lines [] :buflisted false :pos :cc}
                            (or val {}))]
    (tset FloatWin :win (float-win-opt opt val))
    (tset FloatWin :bufnr (vim.api.nvim_create_buf val.buflisted true))
    (tset FloatWin :winnr
          (vim.api.nvim_open_win FloatWin.bufnr true FloatWin.win))))

(fn FloatWin.Print [lines pos]
  (let [lines (if (= (type lines) :string) [lines] lines)]
    (FloatWin:Create {:width 0 :height 0} {: lines : pos})
    (vim.api.nvim_buf_set_lines FloatWin.buf 0 -1 false lines)))

;; coderunner start
(fn split []
  (FloatWin:Create {:width 0.45 :height 0.87 :title " Code Runner "}
                   {:buflisted true :pos :tr}))

(fn run [cmd]
  (split)
  (let [cmd (.. :term " " cmd)]
    (vim.cmd cmd)))

(vim.api.nvim_set_var :Coderunner run)

(vim.cmd "
function! s:coderunner(opts)
    autocmd TermOpen * startinsert
    let l:Run_function = luaeval(\"vim.api.nvim_get_var('Coderunner')\")
    call l:Run_function(a:opts.cmd)
endfunction
let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.coderunner = function('s:coderunner')
")

;; coderunner end

FloatWin
