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

" Adds commands for working with surrounding characters
Plug 'tpope/vim-surround'

" Enhances file tree (netrw)
Plug 'tpope/vim-vinegar'

" Helpers for finding/replacing patterns
Plug 'tpope/vim-abolish'

" Commenting/uncommenting
Plug 'tpope/vim-commentary'

" Git integration
Plug 'airblade/vim-gitgutter'

" Navigation between Vim and Tmux
Plug 'christoomey/vim-tmux-navigator'

" Send commands to Tmux from Vim
Plug 'benmills/vimux'

" A bunch of color schemes
Plug 'chriskempson/base16-vim'

" Provides help menu for shortcut keys
Plug 'liuchengxu/vim-which-key'

" Highlight yanked text briefly
Plug 'machakann/vim-highlightedyank'

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
        \ coc-html
        \ coc-json
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
