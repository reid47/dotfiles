scriptencoding utf-8

runtime plugins.vim
runtime general.vim
runtime appearance.vim
runtime homescreen.vim
runtime languages.vim
runtime utils.vim
runtime bindings.vim

lua package.loaded.helpers = nil
lua require('helpers')

lua package.loaded.colorscheme_reid = nil
lua require('colorscheme_reid')

lua package.loaded.tmux_runner = nil
lua tmux = require('tmux_runner')
