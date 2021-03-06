scriptencoding utf-8

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" Adds language server support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Fuzzy-find in floating window
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
let g:clap_layout = { 'relative': 'editor' }
let g:clap_prompt_format = '  %provider_id%: '
let g:clap_disable_run_rooter = v:true
let g:clap_no_matches_msg = 'No matches.'
let g:clap_selected_sign = { 'text': '*', 'texthl': 'ClapSelectedSign', 'linehl': 'ClapSelected' }
let g:clap_current_selection_sign = { 'text': '►', 'texthl': 'ClapCurrentSelectionSign', 'linehl': 'ClapCurrentSelection' }

" Adds commands for working with surrounding characters
Plug 'tpope/vim-surround'

" Enhances file tree (netrw)
Plug 'tpope/vim-vinegar'

" NERDtree file explorer
Plug 'preservim/nerdtree'
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeStatusline=' '
let NERDTreeIgnore=['\.git$', '\.history$']

" Helpers for finding/replacing patterns
Plug 'tpope/vim-abolish'

" Commenting/uncommenting
Plug 'tpope/vim-commentary'

" Adds commands like :Move, :Delete, :Mkdir, etc.
Plug 'tpope/vim-eunuch'

" Git integration
Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '┃'

" Provides help menu for shortcut keys
Plug 'liuchengxu/vim-which-key'
let g:which_key_disable_default_offset = 1

" Highlight yanked text briefly
Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 300

" TypeScript syntax highlighting
Plug 'leafgarland/typescript-vim'

" Fish shell language support
Plug 'dag/vim-fish'

" Applescript language support
Plug 'vim-scripts/applescript.vim'

" TOML language support
Plug 'cespare/vim-toml'

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

  CocInstall \
        \ coc-css
        \ coc-eslint
        \ coc-go
        \ coc-html
        \ coc-json
        \ coc-lua
        \ coc-python
        \ coc-rls
        \ coc-solargraph
        \ coc-stylelint
        \ coc-tslint
        \ coc-tsserver
        \ coc-vetur
        \ coc-prettier
endfun

" Register as command
command! UpdateAllPlugins call s:UpdateAllPlugins()

