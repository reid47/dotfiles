scriptencoding utf-8

" General settings {{{

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

set ignorecase
set smartcase

syntax enable
colorscheme reid

" Show cursor line in active buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

autocmd InsertLeave * set nopaste " see: https://github.com/neovim/neovim/issues/7994

" File explorer (netrw)
let g:netrw_dirhistmax = 0 " Do not save history or bookmarks (no .netrwhist file)
let g:netrw_banner = 0 " Turn off banner
let g:netrw_liststyle = 0 " Thin listing (one file per line)
let g:netrw_browse_split = 0 " Open files in same window
let g:netrw_altv = 1
let g:netrw_winsize = 16
let g:netrw_list_hide = '\.git$'
let g:netrw_hide = 1

" }}}

" Key bindings & commands {{{

" jj to escape from insert mode
inoremap jj <Esc>`^

" ctrl+p to open fuzzy file search
nnoremap <C-p> :FZF<CR>

" ReloadConfig: reload nvim config
command! ReloadConfig :source $MYVIMRC

fun! GetSyntaxGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" SyntaxGroup: print the syntax highlight group of the element under the cursor
command! SyntaxGroup call GetSyntaxGroup()

" }}}

" Plugin setup {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" Adds language server support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Adds commands for working with surrounding characters
Plug 'tpope/vim-surround'

" Enhances file tree (netrw)
Plug 'tpope/vim-vinegar'

" Helpers for finding/replacing patterns
Plug 'tpope/vim-abolish'

" Fuzzy file searching
Plug 'junegunn/fzf'

" TypeScript syntax higlighting
Plug 'leafgarland/typescript-vim'

" Fish shell language support
Plug 'dag/vim-fish'

" Applescript language support
Plug 'vim-scripts/applescript.vim'

" Git integration
Plug 'airblade/vim-gitgutter'

" Navigation between Vim and Tmux
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" Update plugins

fun! s:UpdateAllPlugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    echo 'Installing plugins...'
    PlugInstall --sync | q
  else
    echo 'Updating plugins...'
    PlugUpdate --sync | q
  endif

  CocInstall --sync \
    'coc-css' \
    'coc-html' \
    'coc-json' \
    'coc-rls' \
    'coc-tsserver' \
    'coc-xml'
endfun

" Register as command
command! UpdateAllPlugins call s:UpdateAllPlugins()

" }}}

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

  let s .= ' %{g:statusline_modes[mode()]} '
  let s .= ' %f'
  let s .= '%='
  let s .= '%y %l:%c'

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

" Language: Markdown {{{

augroup config#markdown
  au!
  au FileType markdown setlocal
    \ spell
    \ wrap
    \ linebreak
    \ nolist
augroup END

" }}}

" Language: Go {{{

augroup config#go
  au!
  au FileType go setlocal
    \ noexpandtab
    \ shiftwidth=4
    \ softtabstop=4
    \ tabstop=4
augroup END

" }}}

" Language: Vim {{{

augroup config#vim
  au!
  au FileType vim setlocal
    \ foldmethod=marker
    \ foldlevelstart=0
augroup END

" }}}

" fzf setup {{{

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
  \      . shellescape(<q-args>), 1, <bang>0
  \ )

augroup config#fzf
  au!
  au! FileType fzf set
    \ laststatus=0
    \ noruler
    \| au BufLeave <buffer> set
      \ laststatus=2
      \ ruler
augroup END

let g:fzf_layout = { 'down': '~20%' }

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Comment'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'PreProc'],
  \ 'fg+':     ['fg', 'Visual'],
  \ 'bg+':     ['bg', 'Visual'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Number'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Constant'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

let g:fzf_history_dir = '~/.local/share/fzf-history'

" }}}
