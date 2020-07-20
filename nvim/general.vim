scriptencoding utf-8

set nocompatible
set mouse=a
set autoread
set hidden

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set foldmethod=syntax " By default, fold according to syntax
set foldlevelstart=99 " Expand all folds to start

set lazyredraw             " Wait until actions are done to re-render text
set nowrap                 " Do not wrap long lines
set number                 " Show line numbers
set showmatch              " Show matching brackets/parentheses
set splitright             " Vertical splits to the right
set termguicolors          " Enable true colors in terminal
set updatetime=100         " 100ms (recommended for GitGutter plugin)
set clipboard+=unnamedplus " Use system clipboard
set timeoutlen=750         " Idle timeout (e.g. time before leader menu appears)
set inccommand=nosplit     " Show preview of command (e.g. s/a/b) while typing

set ignorecase
set smartcase

set fillchars+=vert:\│ " Char for vertical split column (does this work??)

autocmd InsertLeave * set nopaste " see: https://github.com/neovim/neovim/issues/7994

" Show home screen on startup
autocmd VimEnter * lua home.show_home_screen()

" File explorer (netrw)
let g:netrw_dirhistmax = 0 " Do not save history or bookmarks (no .netrwhist file)
let g:netrw_banner = 0 " Turn off banner
let g:netrw_liststyle = 0 " Thin listing (one file per line)
let g:netrw_browse_split = 0 " Open files in same window
let g:netrw_altv = 1
let g:netrw_winsize = 16
let g:netrw_list_hide = '\.git$'
let g:netrw_hide = 1

" Auto-save {{{

" Runs :update at interval specified by updatetime setting.
" :update writes the current buffer if it has been modified.
augroup config#autosave
  au!
  au CursorHold,CursorHoldI * call s:AutoSave()
augroup END

fun! s:AutoSave()
  if &ft =~ 'gitcommit'
    return
  endif

  if bufname() == "" || !&modifiable
    return
  endif

  silent update
endfun

" }}}

" Auto-format {{{

fun! s:TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" Register as command
command! TrimWhitespace call s:TrimWhitespace()

" Trim whitespace whenever writing a buffer
autocmd BufWritePre * :call s:TrimWhitespace()

" }}}

" Terminal {{{

augroup config#terminal
  au!
  au TermOpen * setlocal nonumber norelativenumber
augroup END

" }}}
