" Show cursor line in active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Statusline {{{

set laststatus=2
set statusline=%!BuildStatusLine()
set noshowmode

let g:statusline_modes = {
  \ 'n'  : 'N',
  \ 'no' : 'NO',
  \ 'v'  : 'V',
  \ 'V'  : 'VL',
  \ "\<C-v>" : 'VB',
  \ 's'  : 'S',
  \ 'S'  : 'SL',
  \ "\<C-s>" : 'SB',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'Rv' : 'RV',
  \ 'c'  : 'C',
  \ 'cv' : 'CV',
  \ 'ce' : 'CE',
  \ 'rm' : '?',
  \ 'r?' : '?',
  \ 'r'  : '?',
  \ '!'  : '!',
  \ 't'  : 'T'
  \}

fun! BuildStatusLine()
  let s = ''

  let s .= '%f'
  let s .= '%='
  let s .= '%{g:statusline_modes[mode()]}'
  let s .= ' %l:%c'

  return s
endfun

" }}}

" Tabline {{{

set tabline=%!BuildTabLine()

fun! BuildTabLine()
  let s = ''

  for i in range(tabpagenr('$'))
    let tab_number = i + 1
    let winnr = tabpagewinnr(tab_number)
    let buflist = tabpagebuflist(tab_number)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')

    let s .= '%' . tab_number . 'T'
    let s .= (tab_number == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab_number . ': '

    let s .= empty(bufname) ? '[No Name] ' : bufname . ' '

    let n = tabpagewinnr(tab_number,'$')
    if n > 1 | let s .= '(+' . (n - 1) . ') ' | endif
  endfor

  let s .= '%#TabLineFill#'

  return s
endfun

" }}}
