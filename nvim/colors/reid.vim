" This file is meant to override another color scheme

" Styles
let s:off = "NONE"
let s:bold = "bold"
let s:underline = "underline"
let s:italic = "italic"
let s:bold_italic = "bold,italic"
let s:bold_underline = "bold,underline"

" Color palette
let s:light_gray = "#2e2f4f"
let s:dark_gray = "#75718e"
let s:white = "#f8f8f8"
let s:teal = "#8dd3c7"
let s:yellow = "#ffffb3"
let s:purple = "#ce9aca"
let s:red = "#fb8072"
let s:blue = "#80b1d3"
let s:orange = "#fdb462"
let s:green = "#b3de69"

func! s:Hi(type, guifg, guibg, gui)
  :exe "highlight " . a:type . " guifg=" . a:guifg . " guibg=" . a:guibg . " gui=" . a:gui
endfunc

" Primary foreground/background (if off, uses terminal settings)
call s:Hi("Normal", s:white, s:off, s:off)
call s:Hi("NormalFloat", s:white, s:light_gray, s:off)
" call s:Hi("NormalNC", s:white, s:light_gray, s:off)

" Applies to buffer below text (after numbered lines)
call s:Hi("NonText", s:dark_gray, s:off, s:off)

" The ~ at the end of files
call s:Hi("EndOfBuffer", s:dark_gray, s:off, s:off)

" Cursor & selection
call s:Hi("Cursor", s:orange, s:light_gray, s:off)
call s:Hi("Visual", s:off, s:light_gray, s:off)
call s:Hi("CursorLine", s:off, s:light_gray, s:off)
call s:Hi("CursorColumn", s:off, s:light_gray, s:off)
call s:Hi("ColorColumn", s:off, s:light_gray, s:off)

" Line numbers & sign column
call s:Hi("LineNr", s:dark_gray, s:off, s:off)
call s:Hi("CursorLineNr", s:white, s:light_gray, s:bold)
call s:Hi("SignColumn", s:off, s:off, s:off)

" Vertical split between buffers
call s:Hi("VertSplit", s:white, s:off, s:off)

" Tabs
call s:Hi("TabLine", s:off, s:light_gray, s:off)
call s:Hi("TabLineFill", s:off, s:light_gray, s:off)
call s:Hi("TabLineSel", s:white, s:off, s:bold)

" Matching (, ), {, }, [, ], etc.
call s:Hi("MatchParen", s:off, s:light_gray, s:underline)

" Status line of active buffer
call s:Hi("StatusLine", s:white, s:light_gray, s:bold)
call s:Hi("StatusLineMode", s:white, s:light_gray, s:bold)
call s:Hi("StatusLineNC", s:dark_gray, s:light_gray, s:off)

" Pop-up menus
call s:Hi("Pmenu", s:white, s:light_gray, s:off)
call s:Hi("PmenuSel", s:white, s:dark_gray, s:bold)

" Search
call s:Hi("IncSearch", s:light_gray, s:orange, s:off)
call s:Hi("Search", s:light_gray, s:yellow, s:off)

" Spell-checking
call s:Hi("SpellBad", s:off, s:off, s:underline)

" Underlined text
call s:Hi("Underlined", s:off, s:off, s:underline)

" Italic text
call s:Hi("Italic", s:off, s:off, s:italic)
call s:Hi("markdownItalic", s:off, s:off, s:italic)

" Bold text
call s:Hi("Bold", s:off, s:off, s:bold)
call s:Hi("markdownBold", s:off, s:off, s:bold)

" Diffs & Git markers
call s:Hi("DiffAdd", s:green, s:off, s:bold)
call s:Hi("DiffDelete", s:red, s:off, s:bold)
call s:Hi("DiffChange", s:yellow, s:off, s:bold)
call s:Hi("DiffText", s:off, s:yellow, s:bold)
call s:Hi("GitGutterAdd", s:green, s:off, s:bold)
call s:Hi("GitGutterChange", s:orange, s:off, s:off)
call s:Hi("GitGutterChangeDelete", s:orange, s:off, s:off)
call s:Hi("GitGutterDelete", s:red, s:off, s:off)

" File explorer
call s:Hi("Directory", s:blue, s:off, s:off)
call s:Hi("netrwClassify", s:yellow, s:off, s:off)

call s:Hi("Folded", s:dark_gray, s:off, s:bold_italic)

" Comments
call s:Hi("Comment", s:dark_gray, s:off, s:off)
call s:Hi("Todo", s:dark_gray, s:green, s:bold)


