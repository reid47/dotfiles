autocmd VimEnter * call ShowHomeScreen()

fun! ShowHomeScreen()
  if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    return
  endif

  " Start a new buffer for the home screen
  enew
  setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber

  call DrawScreen()

  " Disallow modifications to this buffer
  setlocal nomodifiable nomodified

  " Syntax-highlight the screen
  call Highlight()

  " When we go to insert mode start a new buffer, and start insert
  nnoremap <buffer><silent> e :enew<CR>
  nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

fun! DrawScreen()
  let banner = [
        \ '',
        \ '                              ████                                             ███',
        \ '                             ░░███                                            ░███',
        \ '     █████ ███ █████  ██████  ░███   ██████   ██████  █████████████    ██████ ░███',
        \ '    ░░███ ░███░░███  ███░░███ ░███  ███░░███ ███░░███░░███░░███░░███  ███░░███░███',
        \ '     ░███ ░███ ░███ ░███████  ░███ ░███ ░░░ ░███ ░███ ░███ ░███ ░███ ░███████ ░███',
        \ '     ░░███████████  ░███░░░   ░███ ░███  ███░███ ░███ ░███ ░███ ░███ ░███░░░  ░░░ ',
        \ '      ░░████░████   ░░██████  █████░░██████ ░░██████  █████░███ █████░░██████  ███',
        \ '       ░░░░ ░░░░     ░░░░░░  ░░░░░  ░░░░░░   ░░░░░░  ░░░░░ ░░░ ░░░░░  ░░░░░░  ░░░ ',
        \]

  for line in banner
    call append('$', line)
  endfor
endfun

fun! Highlight()
  syntax match HomeScreenBanner /█/
  syntax match HomeScreenBannerShadow /░/

  highlight default link HomeScreenBanner Keyword
  highlight default link HomeScreenBannerShadow Comment
endfun

