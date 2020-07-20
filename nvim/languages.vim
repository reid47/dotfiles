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

" Language: Rust {{{

augroup config#rust
  au!
  au FileType rust setlocal
    \ shiftwidth=2
    \ softtabstop=2
    \ tabstop=2
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

" Language: homescreen {{{

augroup config#homescreen
  au!
  au FileType homescreen setlocal
    \ nocursorline
    \ nocursorcolumn
    \ nonumber
    \ norelativenumber
augroup END

" }}}

