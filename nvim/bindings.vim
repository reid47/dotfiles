scriptencoding utf-8

let g:leader_key_map = {}

" Space is the leader
let g:mapleader=' '

" Space + a pause to open the leader menu
nnoremap <silent><nowait> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent><nowait> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', "g:leader_key_map")

" Escape to clear search highlight
nnoremap <esc> :noh<return><esc>

" Tab/shift+tab to indent/unindent
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Group: code actions {{{

let g:leader_key_map.c = {
      \ 'name': 'code actions',
      \}

" Commenting/uncommenting
xmap <c-_> <Plug>Commentary
omap <c-_> <Plug>Commentary
nmap <c-_> <Plug>CommentaryLine
let g:leader_key_map.c['/'] = ['<c-_>', 'Comment/uncomment']

" Hover
let g:leader_key_map.c.c = [":call CocActionAsync('doHover')", 'Hover']

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
let g:leader_key_map.c.d = ["<Plug>(coc-definition)", 'Go to definition']

" Rename symbol
let g:leader_key_map.c.n = ['<Plug>(coc-rename)', 'Rename symbol']

" Format
command! -nargs=0 Format :call CocActionAsync('format')
let g:leader_key_map.c.f = [':Format', 'Format']

" }}}

" Group: running commands {{{

let g:leader_key_map.r = {
      \ 'name': 'run commands',
      \}

let g:leader_key_map.r.c = [':VimuxPromptCommand', 'Run a new command']

let g:leader_key_map.r['.'] = [':VimuxRunLastCommand', 'Re-run last command']

" }}}

" Group: find/search {{{

let g:leader_key_map.f = {
      \ 'name': 'find things',
      \}

xmap <c-p> :Clap files<CR>
omap <c-p> :Clap files<CR>
nmap <c-p> :Clap files<CR>
let g:leader_key_map.f.f = [':Clap files', 'Find file by name']

let g:leader_key_map.f.c = [':Clap command', 'Find command by name']

let g:leader_key_map.f.h = [':Clap history', 'Find in file history']

let g:leader_key_map.f.s = [':Clap grep', 'Find in files']

" }}}
