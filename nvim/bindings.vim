scriptencoding utf-8

let g:leader_key_map = {}

" Space is the leader
let g:mapleader=' '

" Space + a pause to open the leader menu
nnoremap <silent><nowait> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent><nowait> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', "g:leader_key_map")

" Escape to clear search highlight & update git signs
nnoremap <silent><esc> :noh <bar> :GitGutter<return><esc>

" Tab/shift+tab to indent/unindent
vnoremap > >gv
vnoremap < <gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Group: code actions {{{

let g:leader_key_map.c = { 'name': 'code actions' }

xmap <c-_> <Plug>Commentary
omap <c-_> <Plug>Commentary
nmap <c-_> <Plug>CommentaryLine
let g:leader_key_map.c['/'] = ['<c-_>', 'comment/uncomment']

let g:leader_key_map.c.a = [":CocAction", 'open action menu']

let g:leader_key_map.c.c = [":call CocActionAsync('doHover')", 'hover']

nmap <silent> gd <Plug>(coc-definition)
let g:leader_key_map.c.d = ["<Plug>(coc-definition)", 'go to definition']

let g:leader_key_map.c.n = ['<Plug>(coc-rename)', 'rename symbol']

command! -nargs=0 Format :call CocActionAsync('format')
let g:leader_key_map.c.f = [':Format', 'format']

" }}}

" Group: running commands {{{

let g:leader_key_map.r = { 'name': 'run' }

map <leader>rc :lua tmux.run_command()<cr>
let g:leader_key_map.r.c = 'run new command'

map <leader>rf :lua tmux.run_current_buffer()<cr>
let g:leader_key_map.r.f = 'run current buffer'

map <Leader>r. :lua tmux.run_last_command()<CR>
let g:leader_key_map.r['.'] = 'run last command'

" }}}

" Group: search {{{

let g:leader_key_map.s = { 'name': 'search' }

xmap <c-p> :Clap files<CR>
omap <c-p> :Clap files<CR>
nmap <c-p> :Clap files<CR>
let g:leader_key_map.s.f = [':Clap files', 'search files by name']

let g:leader_key_map.s.c = [':Clap command', 'find command by name']

let g:leader_key_map.s.h = [':Clap history', 'find in file history']

let g:leader_key_map.s.g = [':Clap grep', 'search in files']

let g:leader_key_map.s.l = [':Clap lines', 'search lines of current file']

let g:leader_key_map.s.o = [':CocList outline', 'search outline of current file']

let g:leader_key_map.s.y = [':Clap yanks', 'search yanks']

" }}}

" Group: git {{{

let g:leader_key_map.g = { 'name': 'git' }

let g:leader_key_map.g.p = [':GitGutterPreviewHunk', 'preview hunk at cursor']

let g:leader_key_map.g.u = [':GitGutterUndoHunk', 'undo hunk at cursor']

let g:leader_key_map.g['['] = [':GitGutterPrevHunk', 'jump to previous hunk']

let g:leader_key_map.g[']'] = [':GitGutterNextHunk', 'jump to next hunk']

" }}}

" Group: vim config {{{

let g:leader_key_map.v = { 'name': 'vim' }

let g:leader_key_map.v.r = [':ReloadConfig', 'reload vim config']

let g:leader_key_map.v.p = [':UpdateAllPlugins', 'update all plugins']

" }}}

" Group: window {{{

let g:leader_key_map.w = { 'name': 'window' }

nmap <c-j> :NERDTreeToggle<CR>
let g:leader_key_map.w.j = [':NERDTreeToggle', 'toggle file explorer']

" }}}
